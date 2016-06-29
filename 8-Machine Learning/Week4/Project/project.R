require(caret)

getPMLcsv <- function(url, nas) {
    #temp <- tempfile()
    #download.file(url, temp, method = "curl")
    data <- read.csv(url, na.strings = nas)
    #unlink(temp)
    
    return(data)
}

set.seed(5436)

trainurl <- "pml-training.csv"
trainingCSV <- getPMLcsv(trainurl, c("", "NA", "#DIV/0!"))

train_partion <- createDataPartition(y=trainingCSV$classe, p=0.7, list = FALSE)

training <- trainingCSV[train_partion,]
testing <- trainingCSV[-train_partion,]
dim(training)

cols <- nearZeroVar(training)
training <- training[, -cols]

dim(training)


nullcol <- names(cntlength[cntlength < 0.6 * length(training$classe)])
descriptcol <- c("X", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", 
                 "cvtd_timestamp", "new_window", "num_window")
excludecols <- c(descriptcol, nullcol)
training <- training[, !names(training) %in% excludecols]

set.seed(5463)

fitControl <- trainControl(## 10-fold CV
    method = "repeatedcv",
    number = 10,
    ## repeated ten times
    repeats = 10)

fit.rf <- train(classe~., method='rf', data= training, trControl=fitControl)

#fit.gbm <- train(classe~., method="gbm", data= training) 

#pred.gbm <- predict(fit.gbm, newdata=testing)
pred.rf <- predict(fit.rf, newdata = testing)

confusionMatrix(pred.rf,testing$classe )$overall['Accuracy']
#confusionMatrix(testing$classe, pred.gbm)$overall['Accuracy']


