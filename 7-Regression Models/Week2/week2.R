##Q1
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
fit <- lm(y~x)
summary(fit)

##Q2

##Q3
data("mtcars")
x <- mtcars$wt
y<- mtcars$mpg
fit<- lm(y~x)
predict(fit,data.frame(x=mean(x)), interval="confidence")
