# Get-Clean-Data-Project
## Introduction to Readme file
This Readme file contains the explanation for the run_analysis.R script for the data used for this project.

### Creating a directory
The scripts starts with an "if" statement to check for and create a directory called "data" where the online
data can be downloaded to.

### Downloading the dataset
The dataset was downloaded by first assigning the url of the data to "fileUrl" and then downloaded using 
the download.file function. Since the data came as a zip file, the dataset had to be unzipped unsing the unzip
function

### Reading files
The files were .txt files so they were read using the read.table function. They were read as follows:
*  "test" files were read first.
*  "training" files were read second
* "other pertinent info" consisting of features and activity labels were read in last

### Labeling columns 
The names function was used to label the columns of all test and training datasets

### Merging the data
* All training data was merged using cbind
* All test data was merged using cbind
* Having obtained the appropriate dimensions for both training and test data, the two were merged using 
rbind

### Selecting columns with mean and standard deviation
grep and grepl functions were handy in selecting the variables with the mean and standard deviation.
The variables with frequency were dropped as these are mean frequencies. Using the activity labels, the 
variables of the final dataset were descriptively labeled

### Making a tidy dataset
Using the aggregate function in the dplyr package, the means of the variables were calculated by activityName
and subjectNumber. This was afterwards sorted and kept in the wide format. Both wide and long formats are 
good for this dataset

### Writing  the tidy dataset to text file
Using the write.table function, the final tidy dataset was written as a text file for both wide and long 
formats

