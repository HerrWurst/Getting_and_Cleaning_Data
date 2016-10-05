# Coursera 'Getting and Cleaning Data Course Project'
## Introduction
I created this repository to hold everything that is required in the Coursera 'Getting and Cleaning Data Course Project'. In this ReadMe-file I will comment on my script and explain why I believe that my result is tidy.

## Analysis R-script
### Overview
I have created a single R-script which holds all code involved in my course project. It is structured into 3 steps (which do not match the 5-bullet-points in the assignment instructions). The code itself has comments, but I will elaborate here in more detail.

### Step 1: Preparing files
In this code block I download the ZIP-file and save it to my hard drive. I included a check whether the target directory exists, that way you can simply copy and run this without having to read and adjust the code first. However, if you prefer to provide a different target directory you can easily do that by changing the respective variable at the top of the code block. After the download, the file is unzipped into the same directory. Afterwards, the ZIP-file is deleted for clean-up reasons.

### Step 2: Assembling combined dataframe from files
In this code block I read the data from all the relevant files and combine it to one single large dataframe. This covers steps 1 to 4 from the assignment instuctions (yet I am not doing them in the same order).

I found the source files pretty messy, but after some reading and actually looking at the data I came to work under the following assumptions on the files:
* features.txt: This file holds the column names of the various measurements (see X_train.txt / X_test.txt) together with a column number
* activity_lables.txt: This file holds the descriptive activity labels together with an ID that can be used for joining
* X_train.txt / X_test.txt: These files hold the actual measurements. The 'grain' of this dataset is 'measurements per subject-activity-combination'.
* y_train.txt / y_test.txt: These files contain activity IDs in the same grain and order as X_train.txt / X_test.txt. It's basically a single column which can be added to the respective files.
* subject_train.txt / subject_test.txt: These files contain subject IDs in the same grain and order as X_train.txt / X_test.txt. It's basically a single column which can be added to the respective files.


After reading the advice of David Hood on the assignment (https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) I came to the conclusion that I would not need the files in the 'inertial' folders. 
