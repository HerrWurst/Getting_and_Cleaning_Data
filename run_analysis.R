#--------------------------------------------------------------------------------
# STEP 1: Prepare files
#--------------------------------------------------------------------------------
origin <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
directory <- './data'
filename <- 'File.zip'

if (!dir.exists(directory)) {dir.create(directory)}
destin <- paste0(directory, '/', filename)

download.file(origin, destin)
unzip(destin, exdir = directory)
zipfolder <- paste0(directory, '/UCI HAR Dataset/')
file.remove(destin)



#--------------------------------------------------------------------------------
# STEP 2: Assembling combined dataframe from files
#--------------------------------------------------------------------------------
# Read label data; filter features for mean() and std() values
activity_lbl <- read.table(paste0(zipfolder, 'activity_labels.txt'), col.names = c('activityID', 'activity'))

features_all <- read.table(paste0(zipfolder, 'features.txt'), stringsAsFactors = FALSE)
mean_std <- grep('-mean\\(\\)|-std\\(\\)', features_all[[2]])
features_clean <- features_all[mean_std,]

# Create empty dataframe as base structure for fully merged data set; then fill 
# it with both train and test data
combined <- data.frame()

for (set in c('train', 'test')) {
        
        # Set directory variables
        dir_subj <- paste0(zipfolder, set, '/subject_', set, '.txt')
        dir_actv <- paste0(zipfolder, set, '/y_', set, '.txt')
        dir_fact <- paste0(zipfolder, set, '/X_', set, '.txt')

        # Read files and assign column names
        subjects <- read.table(dir_subj, col.names = c('subjectID'))
        activities <- read.table(dir_actv, col.names = c('activityID'))
        facts_all <- read.table(dir_fact, col.names = features_all[[2]])
        
        # From facts, use only mean() and std() columns, then combine everything
        facts_clean <- facts_all[,features_clean[[1]]]
        allcols <- cbind(dataset = set, subjects[1], activities[1], facts_clean)
        combined <- rbind(combined, allcols)
}

# Merge activity labels from file
combined <- merge(x = combined, y = activity_lbl, by.x = 'activityID', by.y = 'activityID')



#--------------------------------------------------------------------------------
# STEP 3: Create tidy dataset
#--------------------------------------------------------------------------------
# Load required libraries
library(dplyr)
library(tidyr)

# Use chained commands to tidy the dataset step by step
tidydata <- combined %>%
        
        # Reorder columns and remove activity ID
        select(dataset, subjectID, activity, everything(), -activityID) %>%
        
        # Transpose dataset
        gather(measurement, value, -dataset, -subjectID, -activity) %>%
        
        # Separate measurement into several columns
        separate(measurement, c('signal', 'measure'), '[\\.]{1}', remove = FALSE, extra = 'drop') %>%
        separate(measurement, c('signal2', 'axis'), '[\\.]{3}', fill = 'right') %>%
        mutate(domain = substr(signal, 1, 1)) %>% 
        mutate(signal = substr(signal, 2, length(signal))) %>%
        mutate(signal = ifelse(!is.na(axis), paste0(signal, ' ', axis, '-axis'), signal)) %>%
        
        # Change values so that they are descriptive
        mutate(measure = sub('std', 'standarddeviation', measure)) %>%
        mutate(domain = sub('f', 'frequency', domain)) %>%
        mutate(domain = sub('t', 'time', domain)) %>%
        mutate(activity = sub('_', ' ', activity)) %>%
        mutate(activity = tolower(activity)) %>%
        
        # Aggregate and transpose dataset
        group_by(dataset, subjectID, activity, domain, signal, measure) %>%
        summarize(avg = mean(value)) %>%
        spread(measure, avg)

# Writing data to a file
dir_result <- paste0(directory, '/tidydata.txt')
write.table(tidydata, dir_result, row.name=FALSE)