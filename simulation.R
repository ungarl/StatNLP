# Stolen from handout


    c1 <- rexp(300)*2
    c2 <- rexp(300)*2
    theta <- .9
    x <- sin(theta)*c1 + cos(theta)*c2
    y <- sin(theta)*c2 - cos(theta)*c1
    range <- c(min(c(x,y)),max(c(x,y)))
    plot(x,y,col="blue",xlim=range,ylim=range)

