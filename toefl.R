#!/usr/bin/Rscript --vanilla
##################################################
#
#   Read in the data
#
#   (Note: the data was generated from ruby.
#   That is the toefl.rb file.
#
##################################################

toefl <- as.data.frame(read.csv("data/toefl.csv"))
#number of questions and choices
n_q = nrow(toefl)
num_choices = 4
#the answers as a vector of strings
answers = as.character(toefl$answer)

dictionary <- read.csv("data/dictionary.csv")
# dictionary = (word, vector)
colnames(dictionary)[1] <- "word"

##################################################
#
#  Confirming we got names with the data
#
##################################################

names(toefl)


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

k<-c(1,2,3)

j<-c(4,5,6)

cosine.similarity(k,j) ########## 0.9746318
cosine.similarity(c(0,1),c(1,0)) ########## should return 0
cosine.similarity(k,k)  ######### should return 1

m <- c(.2, 4, 2)
ans <- generic.guesser(m, cbind(k,j), cosine.similarity)


cosine.guesser <- function(target, candidates, cosine.metric)
{
  generic.guesser(target, candidates, cosine.metric)
}

### Input: (string) target vector, (list) candidates.vector, distance.metric
### Output: closest candidate
generic.guesser <- function(target, candidates, distance.metric){

  closest.candidate <- vector()
  closest.candidate.value <- -Inf
  
  for(ii in 1:ncol(candidates) ){
    this.candidate <- candidates[, ii]
    
    candidate.similarity.value <- distance.metric(target, this.candidate)
    if( candidate.similarity.value > closest.similarity.value ){
      closest.candidate <- this.candidate
      closest.candidate.value <- candidate.similarity.value
    }
  }

  closest.candidate
}


    
cosine.guesser <- function(target, candidates){
	
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


l2.guesser <- function(target, candidates)
  {
	


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
