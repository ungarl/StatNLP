# Here I follow Algorithm A very closely, in the context of a document word-frequency modeling problem

library(MASS)
# command to install - lukasz
# install.packages("Combinations", repos = "http://www.omegahat.org/R", type="source")

library(Combinations)

# Allow things to be reproducible 
set.seed(1)

kl.divergence <- function(p, q) sum(p * log(p/q))

# Make into a discrete probability distribution
make.prob.distr <- function(x) {
  stopifnot(sum(x < 0) == 0)
  stopifnot(sum(x > 0) > 0)
  x/sum(x)
}

# This will store the model parameters. All docs are the same length
dfm <- list(d=10, k=3, num.docs=500, doc.len=40, w=c(0.15,0.30,0.55))

# I start with something like a Zipfs distribution, but enrich for different 
# subsets of words in each topic
dfm$M <- dfm$M <- sapply(c(1,5,9), function(m) 
  make.prob.distr(dnorm(1:dfm$d, mean=m, sd=1.3)+0.6/(1:dfm$d)))

topics <- sample(1:dfm$k, dfm$num.docs, replace=TRUE, prob=dfm$w)
docs <- sapply(topics, function(t) 
  sample(1:dfm$d, dfm$doc.len, replace=TRUE, prob=dfm$M[,t]))

# compute the likelihood of a document according to topic i
doc.log.likelihood <- function(doc, model, i) {
  sum(log(model$M[doc,i]))
}

predict.topic <- function(doc, model) {
  # compute the likelihood of each document for each topic (DxK) where D is num.docs and K=k
  doc.ll <- sapply(1:model$k, function(i) doc.log.likelihood(doc, model, i))
  t <- which.max(doc.ll)
  c(ll=doc.ll[t], topic=t)
}

# see how well we can guess the topic, knowing the true parameters
mean(t(apply(docs, 2, predict.topic, dfm))[,"topic"] == topics)
# [1] 0.99

all.pairs <- function(x) {
  g <- expand.grid(1:length(x), 1:length(x))
  g <- g[g[,1] < g[,2],]
  apply(g, 2, function(pair) x[pair])
}

pairs.all <- do.call(rbind, lapply(1:(dfm$num.docs), function(i) all.pairs(docs[,i])))
Pairs.hat <- matrix(0, ncol=dfm$d, nrow=dfm$d)
for (i in 1:nrow(pairs.all)) {
  j <- pairs.all[i,1]
  k <- pairs.all[i,2]
  Pairs.hat[j,k] <- Pairs.hat[j,k] + 1
}
Pairs.hat <- make.prob.distr(Pairs.hat)

pairs.svd <- svd(Pairs.hat, nu=dfm$k, nv=dfm$k)
U.hat <- pairs.svd$u
V.hat <- pairs.svd$v

Pairs.true <- dfm$M %*% diag(dfm$w) %*% t(dfm$M)
pairs.true.svd <- svd(Pairs.true, nu=dfm$k, nv=dfm$k)
U.true <- pairs.true.svd$u
V.true <- pairs.true.svd$v

# See how well we're estimating Pairs
kl.divergence(Pairs.true, Pairs.hat)
# [1] 0.001243517

# sample n tripples from x
sample.triples <- function(x, n) {
  triples <- matrix(sample(1:length(x), 3*n*3, replace=TRUE), ncol=3)
  triples <- triples[((triples[,1] == triples[,2]) + (triples[,1] == triples[,3]) + (triples[,2] == triples[,3])) == 0,]
  triples <- unique(triples)
  stopifnot(nrow(triples) >= n)
  t(apply(triples[1:n,], 1, function(z) x[z]))
}

# true distribution of tripples
Triples.true.bytopic <- array(NA, dim=c(dfm$k, dfm$d, dfm$d, dfm$d))
for (t in 1:dfm$k) {
  u <- dfm$M[,t]
  u2 <- u %*% t(u)
  for (i in 1:dfm$d) {
    Triples.true.bytopic[t,i,,] <- u2[,i] %*% t(u)
  }
}
Triples.true <- apply(Triples.true.bytopic *dfm$w, c(2,3,4), sum)

# compute the frequency of each possible triple
Triples.hat <- array(0, dim=rep(dfm$d, 3))

# make sure I'm getting a least 1000 triples per cell
triples.per.doc <- 1000 * dfm$d^3 / dfm$num.docs
triples.list <- lapply(1:ncol(docs), function(i) {
  cat(".")
  sample.triples(docs[,i], triples.per.doc)
})
cat("\n")
triples.all <- do.call(rbind, triples.list)
for (i in 1:nrow(triples.all)) {
  h <- triples.all[i,1]
  j <- triples.all[i,2]
  k <- triples.all[i,3]
  Triples.hat[h,j,k] <- Triples.hat[h,j,k] + 1
}
Triples.hat <- make.prob.distr(Triples.hat)

# See how well we estimate Triples
kl.divergence(Triples.true, Triples.hat)
# [1] 0.002168416

estimate.M <- function(eta, U, Pairs, Triples, V) {
  # Compute B(eta)
  Triples.eta <- apply(Triples, c(1,2), function(z) sum(eta * z))
  B.eta <- (t(U) %*% Triples.eta %*% V) %*% ginv(t(U) %*% Pairs %*% V)
  
  # Use the eigenvectors of B to compute M
  B.eigen <- eigen(B.eta)$vectors
  M.hat <- apply(B.eigen, 2, function(e) make.prob.distr(abs(U %*% e)))
  list(M=M.hat, Triples.eta=Triples.eta)
}

# Pick several theta, to see how M.hat depends on this choice
num.eta.samples <- 100
M.hats <- array(NA, dim=c(dfm$d, dfm$k, num.eta.samples))
M.recovered <- array(NA, dim=c(dfm$d, dfm$k, num.eta.samples))
triples.error <- rep(NA, num.eta.samples)
accuracies <- rep(NA, num.eta.samples)
labelings <- matrix(NA, ncol=dfm$k, nrow=num.eta.samples)

for (i in 1:num.eta.samples) {
  # Choose theta according to the recommended method
  theta <- runif(dfm$k)
  theta <- theta / sqrt(sum(theta^2))
  
  # compute eta
  eta <- U.hat %*% theta

  est <- estimate.M(eta, U.hat, Pairs.hat, Triples.hat, V.hat)
  est.recovered <- estimate.M(eta, U.true, Pairs.true, Triples.true, V.true)

  M.recovered[,,i] <- est.recovered$M

  # Compute error (sum of squared differences) between Triples.eta and Triples.hat.eta
  triples.error[i] <- sum((est.recovered$Triples.eta - est$Triples.eta)^2)
  
  # find the permutation that best matches the labeling
  m <- dfm
  m$M <- est$M
  predictions <- t(apply(docs, 2, predict.topic, m))[,"topic"]
  perms <- permutations(dfm$k)
  perm.accurcies <- apply(perms, 1, function(perm) {
    mean(match(predictions, perm) == topics)
  })
  which.relab <- which.max(perm.accurcies)
  accuracies[i] <- perm.accurcies[which.relab]
  labelings[i,] <- perms[which.relab,]
  M.hats[,,i] <- m$M
}

# For the eta I sampled, compute the KL-divergence between Triples(eta) and Triples.hat(eta)

M.hat <- apply(apply(M.hats, c(1,2), median), 2, make.prob.distr)
M.rec <- apply(apply(M.recovered, c(1,2), median), 2, make.prob.distr)

# See how close I got
kl.divergence(dfm$M %*% diag(dfm$w), M.hat %*% diag(dfm$w))
# [1] 0.06076557

ifm <- dfm
rfm <- dfm
# I need to reorder the topics, so the labels match
ifm$M <- M.hat[,c(2,1,3)]
rfm$M <- M.rec[,c(2,1,3)]

# see how well we can guess the topic based on M.hat
mean(t(apply(docs, 2, predict.topic, ifm))[,"topic"] == topics)
# [1] 0.956

M.hat.kls <- apply(M.hats, 3, function(M) {
  kl.divergence(dfm$M %*% diag(dfm$w), M %*% diag(dfm$w))
})

pdf(file="accuracies.pdf", height=3.2, width=9)
par(mar=c(4,4,2,1), mgp=c(2,0.8,0), cex.axis=0.75, mfcol=c(1,2), xpd=NA)
hist(accuracies, main="", xlab="topic-prediction accurracy", col="gray80", border="gray50")
text(0.55, 70, labels="(a)")
hist(M.hat.kls, main="", xlab="KL divergence", col="gray80", border="gray50")
text(-0.3, 58, labels="(a)")
dev.off()


# END
