library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(rattle)

training <- segmentationOriginal[segmentationOriginal$Case=="Train",]
test <-segmentationOriginal[segmentationOriginal$Case=="Test",]

set.seed(125)

CART <- train(Class~., method="rpart", data= training)
fancyRpartPlot(CART$finalModel)

##Question 3
library(pgmm)
library(caret)
library(rattle)

data(olive)
olive = olive[,-1]

model <- train(Area~., method="rpart", data= olive)
testOlive <- as.data.frame(t(colMeans(olive)))

predict(model, newdata = testOlive )
