# Stolen from handout
c1 <- rexp(10000)*2      # variables we want to find
c2 <- rexp(10000)*2
theta <- 0           # rotation to "hide the variables"
x <-   cos(theta)*c1 + sin(theta)*c2
y <-  -sin(theta)*c1 + cos(theta)*c2
range <- c(min(c(x,y)),max(c(x,y)))
##plot(x,y,col="blue",xlim=range,ylim=range)
data <- cbind(x,y)
sigma <- t(data) %*% data
eta <- rnorm(2)
eta <- eta / norm(as.matrix(eta),"F")
tri <- t(data) %*% diag(as.vector(data %*% eta)) %*% data
mysvd <-  svd(tri)
answer <- mysvd$u[1,]
truth <- c(sin(theta), cos(theta))
answer
truth

