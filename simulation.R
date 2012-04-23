# Stolen from handout


    c1 <- rexp(300)*2      # variables we want to find
    c2 <- rexp(300)*2
    theta <- .9           # rotation to "hide the variables"
    x <- sin(theta)*c1 + cos(theta)*c2
    y <- sin(theta)*c2 - cos(theta)*c1
    range <- c(min(c(x,y)),max(c(x,y)))
    plot(x,y,col="blue",xlim=range,ylim=range)

    theta = 2*pi*(seq(0,1,.001))
    x <- sin(theta)
    y <- cos(theta)
    f <- x^3 + y^3
    plot(x,y,type="l",col="blue")
    lines(f*x, f*y,type="l",col="red")
