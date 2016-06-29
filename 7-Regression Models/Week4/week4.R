##Q1: Logistic regression
library(MASS)
data(shuttle)
shuttle2 <- shuttle
shuttle2$use2 <- as.numeric(shuttle2$use=='auto')

regmodel <- glm(formula = use2~as.factor(wind)-1,data= shuttle2,family = binomial)
summary(regmodel)$coef

ex <- exp(coef(regmodel))
ex[1]/ex[2]

exp(cbind(OddsRatio = coef(regmodel), confint(regmodel)))
##Rep: ex[1] ratio de propabilité pour le head, ex[2]= ratio de probalité pour tail

##Q2
library(MASS)
data(shuttle)
shuttle2 <- shuttle
shuttle2$use2 <- as.numeric(shuttle2$use=='auto')

regmodel <- glm(formula = use2~as.factor(wind)+magn-1,data= shuttle2,family = binomial)
summary(regmodel)$coef

ex <- exp(coef(regmodel))
ex[1]/ex[2]

##Q4
data(InsectSprays)
fit<-glm(count~factor(spray)-1,data=InsectSprays,family=poisson)
summary(fit)$coef
ex <- exp(coef(fit))
ex