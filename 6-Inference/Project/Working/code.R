question1 <- function(){
    ##Simple data exploratory
    library(datasets)
    
    d<- ToothGrowth
    
    library(ggplot2)
    
    g <- qplot(dose,len,data=d, facets=supp~.,geom = c("point","smooth"),color=supp)
    g + xlab("Tooth length") + ylab("Dose level of Vitamine C")
    
    g
    
}



analyse_dose <- function(){
    library(datasets)
    d<- ToothGrowth
    
    split_set <- split(d,as.factor(d$supp))
    
    oj <- split_set$OJ
    
    vc <- split_set$VC
   
    oj_len <- oj$len
    vc_len <- vc$len
    
    n1 <- length(oj_len)
    n2 <- length(vc_len)
   
    m1 <- mean(oj_len)
    m2 <- mean(vc_len)
    
    sd1 <- sd(oj_len)
    sd2 <- sd(vc_len)
    
    df <- (sd1^2/n1 + sd2^2/n2)^2/((sd1^4/n1^2)/(n1-1) + (sd2^4/n2^2)/(n2-1))
    
    intvall <- (m1-m2) + c(-1,1)*qt(0.975,df)*(sd1^2/n1 + sd2^2/n2)^0.5
    intvall
    
}

##Project 1

simulation2 <- function(){
    set.seed(5)
    lambda <- 0.2
    n <- 40
    total <- 1000
    
    ##Simulate
    simulated <- replicate(total,rexp(n, lambda))
    
    ##Calculate the mean of 40
    simulated_means <- apply(simulated, 2, mean)
    
    ##Get the experimental mean
    experimental_mean <- mean(simulated_means)
     var_exp <- var(simulated_means)
    st1 <- paste('Sample variance =',var_exp,sep = ' ')
  
    print(st1)
    
   
}

simulation3 <- function(){
    set.seed(5)
    lambda <- 0.2
    n <- 40
    total <- 1000
    
    ##Simulate
    simulated <- replicate(total,rexp(n, lambda))
    
    ##Calculate the mean of 40
    simulated_means <- apply(simulated, 2, mean)
    
    ##Draw the histogram
    hist(as.numeric(simulated_means),breaks=50,main="1000 runs of 40 exponential distributions",xlab="mean of exponential distribution")
    mean_sim <- mean(simulated_means)
    
    ##Add the mean
    abline(v=mean_sim, col="red", lwd=4, lty=20)
    
}