##Q1: find mu
x<-c(0.18, -1.54, 0.42, 0.95)
w<-c(2, 1, 3, 1)
lm(x~1,weights = w)
##Q1 Response: 0.1471

##Q2: Regression to the origine
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

xo<- x-mean(x)
yo<- y-mean(y)

coef(lm(xo~yo-1))
##Q2 response: -0.04462

##Q3: Slope
data("mtcars")
x<- mtcars$mpg
y<- mtcars$wt
coef(lm(x~y))

##Q4 et Q5 répondus

##Q6
x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
xn <- (x-mean(x))/sd(x)

##Q7
beta1 <- cor(y,x)*sd(y)/sd(x)
beta0<- mean(y)-beta1*mean(x)
rbind(c(beta0,beta1),coef(lm(y~x)))

##Q8
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
lm(x~1)
