##Q1: Give the estimate change
data("mtcars")

y<- mtcars$mpg
x1 <- mtcars$cyl
x2 <- mtcars$wt

summary(lm(formula=y~as.factor(x1)+x2))$coeff[3]

##Response = -6.071

##Q2

data("mtcars")

summary(lm(formula=mpg~as.factor(cyl)+wt, data = mtcars))
summary(lm(formula=mpg~as.factor(cyl), data = mtcars))
##Respnse: Holding weight constant, cylinder appears to have 
##less of an impact on mpg than if weight is disregarded.

##Q3
library(lmtest)
suppressMessages(library(lmtest))
y<- mtcars$mpg
x1 <- mtcars$cyl
x2 <- mtcars$wt

fit1 <- lm(y~as.factor(x1)+x2)
fit2 <- lm(y~as.factor(x1)+x2+as.factor(x1):x2)

summary(fit1)$adj.r.squared
summary(fit2)$adj.r.squared

lrtest(fit1,fit2)

##Response: The P-value is larger than 0.05. So, according to our criterion, 
##we would fail to reject, which suggests that the interaction terms 
##may not be necessary

##Q4

fit <- lm(mpg ~ I(wt * 0.5) + as.factor(cyl), data = mtcars)
summary(fit)

##Response: The estimated expected change in MPG per one ton increase 
##in weight for a specific number of cylinders (4, 6, 8).

##Q5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
fit <- lm(y~x)
max(hatvalues(fit))
##Response: 0.9945734
