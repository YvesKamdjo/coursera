#Question 1
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.test$y <- as.factor(vowel.test$y)
vowel.train$y <- as.factor(vowel.train$y)

set.seed(33833)
require(caret)
require(ggplot2)

control <- trainControl(method="cv", number=10)

fit.rf <- train(y~., data= vowel.train, method='rf', trControl = control)


fit.gbm <- train(y~., data= vowel.train, method= 'gbm', trControl = control)

pred.rf <- predict(fit.rf, vowel.test)
pred.gbm <- predict(fit.gbm, vowel.test)

accuracy.rf <- confusionMatrix(vowel.test$y,pred.rf)$overall['Accuracy']
accuracy.gbm <- confusionMatrix(vowel.test$y,pred.gbm)$overall['Accuracy']

agreed <- (pred.rf == pred.gbm)
accuracy.agreed <- confusionMatrix(vowel.test$y[agreed], pred.rf[agreed])$overall['Accuracy']

print('rf Accuracy =')
print(accuracy.rf)

print('gbm accuracy=')
print(accuracy.gbm)

print('Agreed accuracy=')
print(accuracy.agreed)

#Question 2
library(caret)

library(gbm)

set.seed(3433)

library(AppliedPredictiveModeling)

data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)

inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]

training = adData[ inTrain,]

testing = adData[-inTrain,]
set.seed(62433)

control <- trainControl(method="cv", number=10)

fit.rf  <- train(diagnosis~., method='rf', trControl= control, data=training)
fit.gbm <- train(diagnosis~., method='gbm', trControl= control, data=training)
fit.lda <- train(diagnosis~., method='lda', trControl= control, data=training)

pred.rf <- predict(fit.rf, newdata = testing)
pred.gbm <- predict(fit.gbm, newdata = testing)
pred.lda <- predict(fit.lda, newdata = testing)

data.stack <- data.frame(pred.rf,pred.gbm, pred.lda, diagnosis = testing$diagnosis)

fit.stack <- train(diagnosis~., method='rf',data= data.stack)

pred.stack <- predict(fit.stack,newdata=data.stack)

confusionMatrix(testing$diagnosis, pred.gbm)$overall['Accuracy']
confusionMatrix(testing$diagnosis, pred.lda)$overall['Accuracy']
confusionMatrix(testing$diagnosis, pred.rf)$overall['Accuracy']

confusionMatrix(data.stack$diagnosis, pred.stack)$overall['Accuracy']


#Question 3
set.seed(3523)

library(AppliedPredictiveModeling)
library(elasticnet)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]

set.seed(233)
control <- trainControl(method="cv", number=10)
fit.lasso <- train(CompressiveStrength~., method='lasso', data=concrete, trControl= control)

plot.enet(fit.lasso$finalModel, xvar="penalty", use.color=TRUE)

#Question 4

library(lubridate) # For year() function below

dat <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv")

training <- dat[year(dat$date) < 2012,]

testing <- dat[(year(dat$date)) > 2011,]

tstrain <- ts(training$visitsTumblr)
library(forecast)

model.fit <- bats(tstrain)

fcast <- forecast.bats(model.fit, level=95, h=nrow(testing))
acc <- accuracy(fcast, testing$visitsTumblr)

count <- 0
for (i in 1:nrow(testing)) {
    if (testing$visitsTumblr[i] > fcast$lower[i]) {
        if(testing$visitsTumblr[i] < fcast$upper[i]) {
            count <- count + 1}
    }
}
count/nrow(testing)