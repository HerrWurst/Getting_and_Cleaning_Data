# Codebook for tidydata.txt

## Grain
The grain of this dataset is 'average mean and standard deviation values per combination of dataset, subject, activity, domain and signal'. 

## Columns
### dataset
Character variable specifying whether the record is based on data from the training set or from the test set; values:
* train
* test
    
### subjectID
Unique ID referring to the participant of the study; values:
1 ... 30
    
### activity
Character variable specifying which of 6 activities was performed for this record; values:
* walking
* walking upstairs
* walking downstairs
* sitting
* standing
* laying
    
### domain
Character variable specifying the domain of the signal; values:
* time
* frequency
    
### signal
Character variable specifying the specific signal the record is based on; values:
* BodyAcc X-axis
* BodyAcc Y-axis     
* BodyAcc Z-axis
* BodyAccJerk X-axis
* BodyAccJerk Y-axis
* BodyAccJerk Z-axis
* BodyAccMag
* BodyBodyAccJerkMag
* BodyBodyGyroJerkMag
* BodyBodyGyroMag
* BodyGyro X-axis
* BodyGyro Y-axis
* BodyGyro Z-axis
* BodyAccJerkMag
* BodyGyroJerk X-axis
* BodyGyroJerk Y-axis
* BodyGyroJerk Z-axis
* BodyGyroJerkMag
* BodyGyroMag
* GravityAcc X-axis
* GravityAcc Y-axis
* GravityAcc Z-axis
* GravityAccMag
    
### mean
Mean value of the mean measurements if the respective signal, for this dataset, subject, domain and activity; values:
-1 ... 1 (normalized)
    
### standard deviation
Mean value of the standard deviation measurements if the respective signal, for this dataset, subject, domain and activity; values:
-1 ... 1 (normalized)
