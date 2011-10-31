#!/usr/bin/Rscript --vanilla
##################################################
#
#   Read in the data
#
#   (Note: the data was generated from ruby.
#   That is the toefl.rb file.
#
##################################################

toefl <- read.csv("data/toefl.csv")


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

guess.first <- function(target, distractors)
  {
    return(distractors[,1]);
  }


##################################################
#
#  Random guesser
#
##################################################

random.guesser <- function(target, distractors)
  {
    
    ##
    ## insert code here
    ##
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

evaluation <- function(guess, answer)
  {
    #
    # insert code here
    #
  }

###################################################
#
#  Main code
#
##################################################


guess <- guess.first(toefl$target,toefl[,2:5])
evaluation(guess, toefl$answer)


