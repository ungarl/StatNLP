#
# wsd.R
# 
# takes a file with two words in "simple format"
#   and finds the maximally separating direction
#
# currently requires specifying both the filename and the "list" of the two words

# TODO: make sure the desired words are in the file
##################################################################################
#
#   OPTIONS
#
use_connl_states = FALSE      # option:  grab the desired pairs from connl_states.txt
use_all_words = FALSE         # normalize variances using all the words
if(use_all_words) use_connl_states = TRUE
#
##################################################################################
print(paste('use_connl_states: ',use_connl_states))

# pick a source file
filename = "Extractions/happy_sad.txt"
#filename = "Extractions/cat_mouse.txt"
#filename = "Extractions/country_city.txt"
if(use_connl_states) filename = "Extractions/connl_states.txt"

#test.words = c('cat','mouse')
#test.words = c('country','city')
test.words = c('happy', 'sad')
test.words = c('build', 'work')
test.words = c('power', 'part')

# read
if(use_connl_states) 
   {
     target_words = paste(test.words[1],test.words[2])
     system(paste("./find_colors.py ", filename, ' "', target_words, '"'))
     all.words = read.table('colors.txt')
     if(use_all_words)
	all.words = read.table(filename)
   }

if(! use_connl_states)
   {
    print(paste('using words:',test.words[1], ' and', test.words[2]))
    all.words = read.table(filename)
   }

p = dim(all.words)[2] - 1
columns.to.use <- 2:(p+1)    # fist item is the word
labels = all.words[,1]    # this is the transpose of what I expected!
#print(labels)

# mean center
for(i in columns.to.use)
    all.words[,i] =  all.words[,i] - mean(all.words[,i])

all.mat <- as.matrix(all.words[,columns.to.use])

######################################################################################
# project onto the difference between the means
if(! use_all_words)
  {
  # split into the two words
  X1 = all.mat[labels == test.words[1],]
  X2 = all.mat[labels == test.words[2],]

  # project onto the difference and compute the distance from the center

  diff = colMeans(X1) - colMeans(X2)
  print(paste(test.words[1],'> 0 and < 0'))
  print(c(sum(X1 %*% diff > 0), sum(X1 %*% diff < 0)))
  print(paste(test.words[2],'> 0 and < 0'))
  print(c(sum(X2 %*% diff > 0),sum(X2 %*% diff < 0)))
}

######################################################################################
# use rescaled covariances
# NOT FINISHED
# # 1) For each word w in the file, grab the X matrix X_w and compute a covariance matrix Sigma_w for it
# for (w in wordlist)
#   {
#     index = which[labels == w]
#     ...
#    }
# # 2) Sigma = average of those (micro or macro averaged??)
# # 3) find the largest eigenvector of Sigma_w - Sigma
# #     Note: w can be a real word or with multiple meanings or a pseudo word
# 4) use that direction to separate the word meanings/senses


# find means and variance-covariance matrix
X1.centered = scale(X1, scale=FALSE)
X2.centered = scale(X1, scale=FALSE)
X1.var = var(X1.centered)
X2.var = var(X2.centered)

# finished to here
#X1.scaled = X1.centered - X1.var  # wrong!!!
#print( X1.scaled)


######################################################################################
# use rescaled covariances: method 1

# Sigma^{-1/2}  Sigma_w Sigma^{-1/2}


