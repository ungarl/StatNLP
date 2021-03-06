# colors.R
# Plots the first couple of PCs of the eigenfeatures of a selected set of words.
# Supoorts two different formats, Dean's "pretty" format (which isn't)
# and Lyle's "simple" format (which is)

# TODO: print a reasonable error message if not enough words are found

##################################################################################
#
#                            O P T I O N S 
#
plot_PC12 = TRUE		# print 1st and 2nd PCs
plot_PC23 = FALSE		# print 2nd and 3rd PCs
plot_background = FALSE         # plot the background
use_all_words = FALSE           # select only the words specified in read_colors if "FALSE"
simple_format = FALSE	        # reads all words, no header, just each word followed by the eigenfeatures, space delimited
plot_3d = FALSE                 # use interactive 3D view
sample.size = 80                # randomly pick sample.size items to plot for the simple_format case
#
#
##################################################################################
print(paste('plot_PC12=', plot_PC12, ' simple_format=', simple_format, ' use_all_words=', use_all_words))

# pick a source file

filename = "data/pretty_3_grams_PHC_50k_30.csv"
if(use_all_words) filename = "inderpreet/WSD.csv" 
#if(simple_format) filename = "Extractions/happy_sad.txt"
#if(simple_format) filename = "Extractions/country_city.txt"
#if(simple_format) filename = "Extractions/country_city.txt"
#if(simple_format) filename = "Extractions/cat_mouse.txt"
if(simple_format) filename = "Extractions/connl_states.txt"

test_words = c()
if( length(test_words) == 0 ){
  blue_test_words =
    'aggressive angst anguished anxious ashamed bugged chagrin contemptuous cynical desolate despairing disappointing disconcerted discontent discontented disgust disgusting disheartened displeased displeasure dissatisfaction distressed distressing doleful dread dreary edgy fuming gloomy glum grief haughty horrible indignant infuriated insulted irritable loathed melancholy mournful ornery perturbed pessimistic poorly remorse remorseful ridiculed sad sadness shameful snappy sorrowful startled terrified uneasy unenthusiastic ungrateful unhappiness unpleasant vexation vulnerable wary woeful wrath wrathful'
  blue_test_words = strsplit(blue_test_words, " ")[[1]]
  red_test_words =
    'blissful carefree cheerful cheerfulness cheery contented cozy dazzled delightful ecstatic enthusiastic excellent fabulous festive gleeful grateful gratified gratitude grinning incredible jovial jubilant optimism optimistic peaceful perky radiant smiling superb wonderful'
  red_test_words = strsplit(red_test_words, " ")[[1]]
  test_words <- paste( c(blue_test_words, red_test_words), collapse=" ")
}

# pick the words to be plotted (see "categories.txt" for examples)
test_words =
'man woman boy girl lawyer doctor guy farmer teacher citizen mother wife father son husband brother daughter sister boss uncle pressure temperature permeability density porosity stress velocity viscosity gravity tension feet miles pounds degrees inches barrels tons acres meters bytes'
test_words =
'affection affectionate altruism amity amorous approachable befriended beloved bonded brotherly charisma allegiance ardent ardor aspiration aspire devout doubtless embodiment empowered essence marrow'

#test_words = 'mary patricia tricia linda barbara elizabeth liz betsy jennifer maria susan margaret dorothy lisa nancy karen betty helen john robert bob michael mike william david richard charles joseph joe thomas tom christopher daniel dan paul donald george'
#test_words = 'area0 area1 area2 power0 power1 power2'
#if(simple_format) test_words = 'exchange bill'
#if(simple_format) test_words = 'ask management'
#if(simple_format) test_words = 'work management'

colorVector = c()
FindWords <- function(word.list, colors.words){
  word_indices <- c()
  for( ii in 1:length(word.list) ){
    word_indices <- c( word_indices, which(word.list[ii] == as.character(colors.words$Word_3PHC2)) )
  }
  word_indices
}

if(! simple_format)
  {
    if (! use_all_words) system(paste("./find_colors.py ", filename, ' "', test_words, '"'))
    if(use_all_words) system(paste("cp ",filename," colors.csv"))

    colors = read.csv("colors.csv",header=T)   # selected words
    colorVector = rep("black", length(colors$Word_3PHC2))
    colorVector[FindWords(blue_test_words, colors)] = "blue"
    colorVector[FindWords(red_test_words, colors)] = "red"
    all.words = read.csv(filename,header=T)
  }

# simple_format takes all words is simple format
if(simple_format) 
   {
    if (! use_all_words) system(paste("./find_colors.py ", filename, ' "', test_words, '"'))
    if(use_all_words) system(paste("cp ",filename," colors.txt"))

    colors = read.table('colors.txt') #  reads space delimited, no header
    sample_inds = sample(1:dim(colors)[1], sample.size)
    colors = colors[sample_inds,]  # subsample the data to make plots legible
    all.words = read.table(filename) #  reads space delimited, no header
    all.words = all.words[sample_inds,] # subsample the data to make plots legible
   }

if (! simple_format)
    {
      # best: just the attribute dictionary
       columns.to.use <- 6:35    # attribute dictionary only
      #columns.to.use <- 36:125  # context only for 4-grams, state size 30
      #columns.to.use <- 6:125   # attribute + context for 4-grams, state size 30
      #columns.to.use <- 36:95  # context only for 3-grams, state size 30
      #columns.to.use <- 6:95   # attribute + context for 3-grams, state size 30
    }

if (simple_format)
    {
      p = dim(all.words)[2]
      columns.to.use <- 2:p    # first item is the word
    }

# mean center
for(i in columns.to.use)
  {
    all.words[,i] =  all.words[,i] - mean(all.words[,i])
    colors[,i] =  colors[,i] - mean(colors[,i])
  }

c.mat <- as.matrix(colors[,columns.to.use])
all.mat <- as.matrix(all.words[,columns.to.use])

c.svd <- svd(c.mat)

if(!plot_3d)
  {
    if (plot_PC12) basis = c.svd$v[,1:2]  # project onto the first two PCs
    if (plot_PC23) basis = c.svd$v[,2:3]  # project onto the second and third PCs
                                        #scaling <-  diag(1/c.svd$d[1:2])
    scaling <-  diag(c(1,1))

                                        # full reconstruction
                                        # colSums(c.mat - c.svd$u %*% diag(c.svd$d) %*% t(c.svd$v))
                                        # best 2d reconstruction
                                        # colSums(c.mat - c.svd$u[,1:2] %*% diag(c.svd$d) %*% t(basis))

    xy = c.mat %*% basis %*% scaling
    xlimits = c(min(xy[,1],0),max(xy[,1],0))
    ylimits = c(min(xy[,2],0),max(xy[,2],0))

    # FIX: following seems to be messed up
    if (plot_PC12 &&  plot_background) 
          plot(c.mat %*% basis %*% scaling,col="white",asp=1,xlim=xlimits,ylim=ylimits,xlab="PC 1",ylab="PC 2")
    if (plot_PC12 && !plot_background) 
          plot(c.mat %*% basis %*% scaling,col="white",asp=1,xlab="PC 1",ylab="PC 2")
    if (plot_PC23) 
          plot(c.mat %*% basis %*% scaling,col="white",asp=1,xlab="PC 2",ylab="PC 3")
    # plot the names of the words (TODO: make option to plot colored dots)
    if(!plot_background) {
          text(c.mat %*% basis  %*% scaling,labels=colors[,1],col=colorVector,cex=1.5)
        }
    # Plot invisible points 
    if( plot_background) {
      values <- all.mat %*% basis  %*% scaling
      points(values[101:1000,],col="gray",pch=16,asp=.4)         # obscure words are dots
      #points(c.mat %*% basis %*% scaling,col="blue",pch=16)
      # Plot words
      text(values[1:100,],labels=all.words[1:100,1],col="blue")   # background words
      text(c.mat %*% basis  %*% scaling,labels=colors[,1],col="red",cex=1.5)   # foreground words
    }
  }

if(plot_3d)
  {
    library(rgl)
    basis = c.svd$v[,1:3]  
    scaling <-  diag(c(1,1,1))
    xyz = c.mat %*% basis %*% scaling
    plot3d(xyz, col="red", size=5,ignoreExtent=TRUE)
    if(plot_background)
      {
        values <- all.mat %*% basis  %*% scaling
        keep <- (values[,1] > 0) # && (value[,2] > 0) && (value[,3] > 0)
        points3d(values[keep[1:1000],],col="green",pch=16,size=2,front="cull",back="lines")         # obscure words are dots
        bbox3d(color="white")
      }
    rgl.texts(xyz, col="black", text=colors[,1],cex=1.5)
  }


#
#   M D S
#
#d <- dist(c.mat)
#fit <- cmdscale(d)
#plot(fit)
#text(fit,labels=colors[,1],col="red")


