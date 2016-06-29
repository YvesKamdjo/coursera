readfile <- function(pathname){
    
    #x_test  <- "UCI HAR Dataset/test/X_test.txt"
    #x_train <- "UCI HAR Dataset/train/X_train.txt"
    if(file.exists(pathname))
        outcome <- read.table(pathname)
    else
        stop("The file doesn't exist")
    
    return(outcome)
}

#processing of Training and test sets
processed <- function(){
   
     #Firstly we have to get all data features: Labels, features,...
    
    ## 1 -activity labels
    activity_lab <- readfile("activity_labels.txt")
    
    names(activity_lab) <- c("Activity_ID","Activity_Label")
    
    
    ##2- features: The set of variables that were estimated
    features <- readfile("features.txt")
    
    extract_col <- grep(".*mean.*|.*Std.*", features[,2]) 
    
    # First reduce the features table to what we want
    features <- features[extract_col,]
    
    ##3- subject test & subject training
    subj_test    <- readfile("subject_test.txt")
    subj_train   <- readfile("subject_train.txt")
    
    #Now we are going to read the training and the test data
    X_train <- readfile("X_train.txt")
    X_test  <- readfile("X_test.txt")
    
    ##Before merging, we extract only relevant columns
   
    X_train  <- X_train[,extract_col]
    X_test   <- X_test[,extract_col]
    
    # Naming 
    colnames(X_train) <- features[,2]
    colnames(X_test)  <- features[,2]
    
   # Managing activities labels: y_train, y_test: One column tables= Labels ID
    y_train <- readfile("y_train.txt")
    y_test  <- readfile("y_test.txt")
    
    names(y_train) <- "Activity_ID"
    names(y_test) <- "Activity_ID"
    
    ##Add activities names (activity_lab) as a second column to y_train and y_test
    y_train <- merge(y_train,activity_lab,by.x="Activity_ID",by.y="Activity_ID")
    y_test <- merge(y_test,activity_lab,by.x="Activity_ID",by.y="Activity_ID")
    
    #Names subjects data frame
    names(subj_train) <- "SUBJECT_ID"
    names(subj_test) <- "SUBJECT_ID"
   
    ##1-Merge test data by binding columns: subject,y_test and X_test
    
    test_data <- cbind(as.data.frame(subj_test),y_test,X_test)
    
    ##2- Merge training data by binding columns
    
    train_data <- cbind(as.data.frame(subj_train),y_train,X_train)
    
    ##3- Finally, we merge test and training data by rows to obtain the final data set
    
    final_data  <- rbind(test_data,train_data)
    #str(final_data)
   
    # create the tidy data set
   library(reshape2)
    
    ##First melt by subject and activity
    
    melting <- melt(final_data,id.vars=c("SUBJECT_ID","Activity_ID"),measure.vars=features[,2])
    
    ##Dcast
    melting <- dcast(melting, SUBJECT_ID+Activity_ID ~ variable, mean)
    
    ##Write in a file
    write.csv(melting, file="tidy.csv", sep=",")
}