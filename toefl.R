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

dictionary <- read.csv("data/dictionary.csv", header=FALSE)
# dictionary = (word, vector)
colnames(dictionary)[1] <- "word"
# print(colnames(dictionary))
# dictionary
      
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

wl <- function(...){
  cat(..., fill=TRUE); flush.console();
}

random.guesser <- function(target, candidates)
  {
    wl("random.guesser init..")
    n.candidates <- ncol(candidates)
    random.candidate.idx <- floor( runif(1, 1, n.candidates + 1) )
    wl("..random.guesser end.")
    return( candidates[, random.candidate.idx] )
  }

##################################################
#
#  Cosine Guesser 
#
##################################################

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
    this.candidate <- candidates[ii]
    
    candidate.similarity.value <- distance.metric(target, this.candidate)
    if( candidate.similarity.value > closest.similarity.value ){
      closest.candidate <- this.candidate
      closest.candidate.value <- candidate.similarity.value
    }
  }
  
  closest.candidate
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
