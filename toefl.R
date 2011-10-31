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
