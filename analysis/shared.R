#replace by your directory
setwd("C:\\Users\\kapelner\\Documents\\NetBeansProjects\\nlp_group\\StatNLP")

#load up the original data
X = as.data.frame(read.csv("data/toefl.csv", header = TRUE))
#number of questions and choices
n_q = nrow(X)
num_choices = 4
#the answers as a vector of strings
answers = as.character(X$answer)