# Code Book

 This code book describes the variables, the data, and any transformations or work that I performed to clean up the data
 
 
## Overview
 
 The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years:
 
1. Each person performed six activities:

    * WALKING
    * WALKING_UPSTAIRS
    * WALKING_DOWNSTAIRS
    * SITTING
    * STANDING
    * LAYING


2. Each of them wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope.


3. we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

4. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

## The files

The dataset includes the following files:

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Processing steps

1. Read all the relevant files from the root directory (features.txt,activity_labels.txt) and directories test and train, name the columns.
2. For the data sets X_train and X_test, select only columns in which there are the word 'mean' and 'std'
3. Bind by columns the test data: subject_test, y_test and X_test
4. Bind By columns the training data: subject_train, y_train and X_train
5. Bind by rows the test and training data to get the entire data into a single file
6. Now, create a second independant tidy data with the average of each variable fo each activity and each subject:
    * Melting the data obtains in step 5, by Activity ID and subject ID to get a new data frame with 4 columns: Subject, Activity, variable and value
    * Cast the melting data
    * write the resulte in a CSV file.



