library(caret)

trainingCSV <- read.csv('pml-training.csv', na.strings = c("", "NA", "#DIV/0!"))

##Subsetting and Cleaning data set

train_partion <- createDataPartition(y=trainingCSV$classe, p=0.7, list = FALSE)

training <- trainingCSV[train_partion,]
testing <- trainingCSV[-train_partion,]

##Cleaning data : Remove near zero variables with the caret package function nearzero

cols <- nearZeroVar(training)
training <- training[, -cols]

## create another subset without NZV variables:

NZVvars <- names(training) %in% c("new_window", "kurtosis_roll_belt", "kurtosis_picth_belt",
                                  "kurtosis_yaw_belt", "skewness_roll_belt", "skewness_roll_belt.1", "skewness_yaw_belt",
                                  "max_yaw_belt", "min_yaw_belt", "amplitude_yaw_belt", "avg_roll_arm", "stddev_roll_arm",
                                  "var_roll_arm", "avg_pitch_arm", "stddev_pitch_arm", "var_pitch_arm", "avg_yaw_arm",
                                  "stddev_yaw_arm", "var_yaw_arm", "kurtosis_roll_arm", "kurtosis_picth_arm",
                                  "kurtosis_yaw_arm", "skewness_roll_arm", "skewness_pitch_arm", "skewness_yaw_arm",
                                  "max_roll_arm", "min_roll_arm", "min_pitch_arm", "amplitude_roll_arm", "amplitude_pitch_arm",
                                  "kurtosis_roll_dumbbell", "kurtosis_picth_dumbbell", "kurtosis_yaw_dumbbell", "skewness_roll_dumbbell",
                                  "skewness_pitch_dumbbell", "skewness_yaw_dumbbell", "max_yaw_dumbbell", "min_yaw_dumbbell",
                                  "amplitude_yaw_dumbbell", "kurtosis_roll_forearm", "kurtosis_picth_forearm", "kurtosis_yaw_forearm",
                                  "skewness_roll_forearm", "skewness_pitch_forearm", "skewness_yaw_forearm", "max_roll_forearm",
                                  "max_yaw_forearm", "min_roll_forearm", "min_yaw_forearm", "amplitude_roll_forearm",
                                  "amplitude_yaw_forearm", "avg_roll_forearm", "stddev_roll_forearm", "var_roll_forearm",
                                  "avg_pitch_forearm", "stddev_pitch_forearm", "var_pitch_forearm", "avg_yaw_forearm",
                                  "stddev_yaw_forearm", "var_yaw_forearm")
training <- training[!NZVvars]

training_bis <- training

for(i in 1:length(training)) { #for every column in the training dataset
    if( sum( is.na( training[, i] ) ) /nrow(training) >= .6 ) { #if n?? NAs > 60% of total observations
        for(j in 1:length(training_bis)) {
            if( length( grep(names(training[i]), names(training_bis)[j]) ) ==1)  { #if the columns are the same:
                training_bis <- training_bis[ , -j] #Remove that column
            }   
        } 
    }
}

training <- training_bis

fitControl <- trainControl(## 10-fold CV
    method = "repeatedcv",
    number = 10,
    ## repeated ten times
    repeats = 10)

fit.rf <- train(classe~., method='gbm', data= training)#trControl=fitControl


#fit.gbm <- train(classe~., method="gbm", data= training, trControl=fitControl) 

#pred.gbm <- predict(fit.gbm, newdata=testing)
pred.rf <- predict(fit.rf, newdata = testing)

confusionMatrix(pred.rf,testing$classe )$overall['Accuracy']

testing <- read.csv('pml-testing.csv', na.strings = c("", "NA", "#DIV/0!"))
pred.testing <- predict(fit.rf, newdata = testing)

pred.testing

confusionMatrix(testing$classe, pred.testing)