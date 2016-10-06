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

#### The data
I found the source files pretty messy, but after some reading and actually looking at the data I came to work under the following assumptions on the files:
* features.txt: This file holds the column names of the various measurements (see X_train.txt / X_test.txt) together with a column number
* activity_lables.txt: This file holds the descriptive activity labels together with an ID that can be used for joining
* X_train.txt / X_test.txt: These files hold the actual measurements. The 'grain' of this dataset is 'measurements per subject-activity-combination'.
* y_train.txt / y_test.txt: These files contain activity IDs in the same grain and order as X_train.txt / X_test.txt. It's basically a single column which can be added to the respective files.
* subject_train.txt / subject_test.txt: These files contain subject IDs in the same grain and order as X_train.txt / X_test.txt. It's basically a single column which can be added to the respective files.
* The files in the 'train' and the 'test' subfolders are of equivalent structure, meaning they have differing numbers of rows, but identical columns in the same order.
* After reading the advice of David Hood on the assignment (https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) I came to the conclusion that I do not need the files in the 'inertial' folders.

#### The code
I begin this codeblock by reading in what I call the 'metadata', that is the activity labels from activity_lables.txt and the measurement column names from features.txt. This data is valid for both the train and the test data sets. For this and all subsequent files I do already provide column names when reading the data, although in the assignment instructions that is listed as point 4.

As I do not need all the measurements (which I call facts), but only the ones labelled mean() and std(), I use a simple regular expression in the grep()-function to create a vector of only the relevant rows from features.txt. This vector I will use for subsetting later on. The assignment is not perfectly clear on whether the 'meanFreq()' columns are relevant as well, so I decided to ignore them.

Next comes the code where I read in all the actual data and combine it to a single dataframe. First, I initiallize an empty dataframe. 

I decided to put most steps into a for-loop, as train and test data can be processed the same way. After setting the directory variables I read in all necessary data, already providing descriptive column names. Then I use the vector I prepared to extract only the mean() and std() columns from the facts data. Next, I cbind the columns from the various dataframes together. In this step, I also create a new column holding information on whether this observation comes from the training or the test dataset. Finally, I rbind everything to the prepared result dataframe. This last step also makes sure that the train and the test data is combined into a single dataframe.

After the loop I merge the activity labels to the combined dataframe. I do this last to avoid wrongly sorted data, because the merge()-function reorders the resulting dataset. 

### Step 3: Create tidy dataset
In this code block I tidy the data step by step and create the result required for bullet point 5 in the assignment instructions.

#### What I consider tidy
From all I understand there is more than one possible solution for this assignment. I follow the definition given in Hadley Wickhams article on tidying data (http://vita.had.co.nz/papers/tidy-data.pdf). He states that, in tidy data, 'Each variable forms a column', 'Each observation forms a row' and 'Each type of observational unit forms a table'. I will ignore the third part, as a single table is requested in the assignment. 

From looking at the data, the 'messiness' I see is that the column headers are actually values and that each header holds values of several variables.

From the features_info.txt I understand that each header can be broken down into a domain info (time or frequency), a signal and a measurement for the signal (mean, standard deviation, maximum etc.) For example, the header 'tBodyAcc-Y' can be expressed as 'domain value: time' (due to the 't' at the beginning), 'signal value: BodyAcc on the Y-axis' with a measurement value of type mean.

My result represents this idea. I decided against a column 'axis', as an axis value is not given for every signal. I therefore interpret it as part of the signal info. As measurements of type mean and standard deviation are provided for every signal observation I decided to use those as individual columns, although they could be interpreted as values of a measurement column.

I decided for a long table design, as I find them more tidy in general, but a wide table would have been ok as well I believe.

#### The code
I begin by loading the libraries I intend to use for this assignment. Then follows a sequence of chained commands in which I tidy the data step by step.

First, I reorder the dataset. I then transpose all the measurement columns, so I have the column headers as values instead of columns. 

Now I can split up the signal information into several columns. I do that by the separate function and several substrings, which is a wee bit tedious. It gets the job done, though.

I then chain several mutate-commands with the intent of providing nice, descriptive labels.

And after all that is done I aggregate the dataset and calculate the mean of each set of measurements. It is in this step that I 're-transpose' the measurement types of mean and std back into individual columns.

Finally, I save the result to a file. You can read it into your R via 
If you have run my script beforehand you can use 
data <- read.table('./data/tidydata.txt', header = TRUE)
