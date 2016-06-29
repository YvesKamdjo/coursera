exploratory <- function (){
    data(mtcars)
    data <- mtcars
    require(ggplot2)
    
    g = ggplot(
                data=mtcars, 
                aes(
                   y=mpg,
                   x=factor(am),
                   colour=factor(am)
                   )
               )
    ##g = g + geom_boxplot(outlier.colour = "green", outlier.size = 3)
    g = g+ geom_point()
    g = g + geom_smooth(method='lm', colour="black", aes(group=0))
    g = g + xlab("Auto(0) - manual(1) transmission") + ylab("Miles/Galon")
    g+ scale_fill_brewer(palette="Dark2")
    
}

linearity <- function (){
    data(mtcars)
    
    require(graphics)
   
    fit <- lm(formula= mpg~as.factor(am)+qsec+wt,data=mtcars)
    pre <- predict(fit)
    res <- resid(fit)
    
    scatter.smooth(x = pre,y = res,xlab = "Fitted", ylab = "Residuals",lpars =
                       list(col = "red", lwd = 3, lty = 3))
    abline(0,0)
}

correlation <- function (){
    data(mtcars)
    
    require(graphics)
    library(MASS)
    
    fit <- lm(formula= mpg~as.factor(am)+qsec+wt,data=mtcars)
    pre <- predict(fit)
    stud <- studres(fit)
    
    scatter.smooth(x = pre,y = stud,xlab = "Fitted", ylab = "Studentized Residuals")
    abline(0,0)
}


analyse1 <- function(){
    data(mtcars)
    fit <- lm(formula= mpg~.,data=mtcars)
    pre <- predict(fit)
    res <- resid(fit)
    plot(x = pre,y = res,xlab = "Fitted", ylab = "Residuals")
    abline(0,0)
   
    
}

analyse2 <- function(){##Residual errors analysis
    data(mtcars)
    library(MASS)
    
    fit <- lm(formula= mpg~as.factor(am)+qsec+wt,data=mtcars)
    pre <- predict(fit)
    res <- resid(fit)
    stud <- studres(fit)
    plot(x = pre,y = stud,xlab = "Fitted", ylab = "Studentized")
    abline(0,0)
}