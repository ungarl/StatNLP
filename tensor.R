#I've just implemented Algorithm A(code attached), on simulated 
#data where the hidden state and observations are all discrete. It #seems that when the state is 3 dimensional and observation is 4 #or 5 is algorithm can recover the some columns of the observation #matrix, up to a permutation of columns(works most of the time, #when you can figure out some column in the estimator corresponds #to some column in the truth by merely looking at the two #matrices). But sometimes it will run into complex eigenvectors #because we are doing eigenvalue decomposition for asymmetric #matrix(which is usual when k=4,5..). I don't think this algorithm #can recover the whole observation matrix with a single probe #vector eta, but it do recover some columns very well in these #tiny examples.


k<-4# hidden state dim
m<-5#observations
P<-runif(k) 
P<-P/sum(P) ###mixture weight
M<-matrix(data=0,m,k)
for(i in 1:k)
{
	tp<-runif(m)
	tp<-tp/sum(tp)
	M[,i]<-tp
} #emission matrix
######randomly generate emission and mixture weight above####


#k<-3
#m<-3
#P<-c(0.2,0.7,0.1)
#M<-matrix(data=c(0.8,0.1,0.1,0.2,0.7,0.1,0,0.2,0.8),3,3)
####above is an easier example where the algorithm works pretty well####
gen_samp=function(size,P,M)
{
	s<-length(P)
	o<-nrow(M)
	v1<-matrix(data=0,nrow=size,ncol=o)
	v2<-matrix(data=0,nrow=size,ncol=o)
	v3<-matrix(data=0,nrow=size,ncol=o)
	state<-sample(1:s,size,replace=TRUE,prob=P)
	for(i in 1:size)
	{
		v1[i,sample(1:o,1,prob=M[,state[i]])]<-1
		v2[i,sample(1:o,1,prob=M[,state[i]])]<-1
		v3[i,sample(1:o,1,prob=M[,state[i]])]<-1
	}
	return(list(v1=v1,v2=v2,v3=v3))
}# function for generating data,v1,v2,v3 are three views

size<-500000
data<-gen_samp(size,P,M)
eta<-runif(m)
Peta<-t(data$v1)%*%(as.vector(data$v3%*%eta)*data$v2)/size
P12<-t(data$v1)%*%data$v2/size
svd12<-svd(P12)
U<-svd12$u[,1:k]
V<-svd12$v[,1:k]
B<-t(U)%*%Peta%*%V%*%solve(t(U)%*%P12%*%V)
#svdB<-svd(B)
#est1<-U%*%svdB$u
est<-U%*%eigen(B)$vectors
for(i in 1:k)# rescaling
{
	est[,i]<-est[,i]/sum(est[,i])
}

M   ###true emission matrix 
est ###estimator