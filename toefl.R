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
#  Insert your method here
#
##################################################



##################################################
#
#  Evaluation
#
##################################################

evaluate <- function(guess_vec)
  {
	  sum(guess_vec == answers) / n_q
  }

  evaluate_and_control_for_guesses = function(guess_vec){
	prop_corr = evaluate(guess_vec)
	prop_chance = n_q * (1 / num_choices) / n_q
	(prop_corr - prop_chance) / (1 - prop_chance)
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
