!/usr/bin/Rscript --vanilla
##################################################
#
#   Read in the data
#
#   (Note: the data was generated from ruby.
#   That is the toefl.rb file.
#
##################################################

toefl <- as.data.frame(read.csv("data/toefl.csv",header=F))
#number of questions and choices
n_q = nrow(toefl)
num_choices = 4
#the answers as a vector of strings
answers = as.character(toefl$answer)

dictionary <- read.csv("data/dictionary.csv")
# dictionary = (word, vector)
colnames(dictionary)[1] <- "word"

#load up the three gram dic, put the words as rownames and make it look nice
three_gram_dic = read.csv("data/dictionary.3_grams_50k.csv")
rownames(three_gram_dic) = three_gram_dic[, 1]
three_gram_dic = three_gram_dic[, -1]
colnames(three_gram_dic) = paste("vec_", seq(1 : ncol(three_gram_dic)), sep = "")
#now you can use this like > three_gram_dic["accelerate", ] 

##################################################
#
#  Confirming we got names with the data
#
##################################################

names(toefl)

##################################################
#
#  Generic Guesser
#
##################################################
### Input: (string) target vector, (list) candidates.vector, distance.metric
### Output: closest candidate (argmin)
generic.guesser <- function(target, candidates, distance.metric){

  closest.candidate <- vector()
  closest.similarity.value <- -Inf

  for(ii in 1:ncol(candidates) ){
    this.candidate <- candidates[, ii]

    candidate.similarity.value <- distance.metric(target, this.candidate)
    if( candidate.similarity.value > closest.similarity.value ){
      closest.candidate <- this.candidate
      closest.similarity.value <- candidate.similarity.value
    }
  }

  closest.candidate
}





##################################################
#
#  Guess first
#
##################################################

guess.first <- function(target, candidates)
  {
    return(candidates[,1]);
  }


##################################################
#
#  Random guesser
#
##################################################

random.guesser <- function(target, candidates)
  {
    n.candidates <- ncol(candidates)
    random.candidate.idx <- floor( runif(1, 1, n.candidates + 1) )
    return( candidates[, random.candidate.idx] )
  }

##################################################
#
#  Cosine Guesser 
#
##################################################
cosine.similarity <- function(vector1,vector2)
 {
	sim.cosine<- vector1%*%vector2/(sqrt(sum(vector1^2)*sum(vector2^2)))
	return(sim.cosine)
 }

cosine.guesser <- function(target, candidates)
{
  generic.guesser(target, candidates, cosine.similarity)
}

### Example cosine guesser (uses function generic.guesser below)

k<-c(1,2,3)
j<-c(4,5,6)
kj <- cbind(k,j)

cosine.similarity(k,j) ########## 0.9746318
cosine.similarity(c(0,1),c(1,0)) ########## should return 0
cosine.similarity(k,k)  ######### should return 1

m <- c(6, 4, 2)
ans <- cosine.guesser(m, cbind(k,j) )


##################################################
#
#  L2 Guesser 
#
##################################################
l2.similarity <- function(vector1,vector2){
  sim.l2<- sum((vector1-vector2)^2)
  sim.l2
}


l2.guesser <- function(target, candidates){
  generic.guesser(target, candidates, l2.similarity)
}
 
##################################################
#
#  Generic Guesser
#
##################################################
### Input: (string) target vector, (list) candidates.vector, distance.metric
### Output: closest candidate (argmin)
generic.guesser <- function(target, candidates, distance.metric){

  closest.candidate <- vector()
  closest.similarity.value <- -Inf
   
  for(ii in 1:ncol(candidates) ){
    this.candidate <- candidates[, ii]
    
    candidate.similarity.value <- distance.metric(target, this.candidate)
    if( candidate.similarity.value > closest.similarity.value ){
      closest.candidate <- this.candidate
      closest.similarity.value <- candidate.similarity.value
    }
  }
}

##################################################
#
#  L2 Guesser 
#
##################################################
l2.similarity <- function(vector1,vector2)
 {
	sim.l2<- sum((vector1-vector2)^2)
	return(sim.l2)
 }
k<-c(1,2,3)

j<-c(4,5,6)

l2.similarity(k,j) ########## should be 27 
l2.similarity(c(0,1),c(1,0)) ########## should return 2
l2.similarity(k,k)  ######### should return 0



l2.guesser <- function(target, candidates){

}


##################################################
#
#  Insert your method here
#
##################################################




##################################################
#
#  Evaluation
#
##################################################

#this evaluate the percentage correct
evaluate <- function(guess_vec)
  {
	  sum(guess_vec == answers) / n_q
  }

#this evaluates the percentage correct controlling for guessing given the 
#standard formula found on p220 of LSA, Landauer & Dumais, 1997
evaluate_and_control_for_guesses = function(guess){
	prop_corr = evaluate(guess)
	prop_chance = n_q * (1 / num_choices) / n_q
	max((prop_corr - prop_chance) / (1 - prop_chance), 0)
}


###################################################
#
#  Main code
#
##################################################


guess <- guess.first(toefl$target,toefl[,2:5])
evaluate(guess)
evaluate_and_control_for_guesses(guess)

guess.two <- random.guesser(toefl$target, toefl[, 2:5])
evaluate(guess.two)
evaluate_and_control_for_guesses(guess.two)
