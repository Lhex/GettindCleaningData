#Getting Data

In this readme file, the explanation for each h2 title corresponds to the parts in run_analysis.R file with the same title as comments.

##Attaining Data

Download the file from the link given, https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, and unzip it.

##Reading Data

1. The data from Train set are read, as well as the ones from Test set.
2. "features.txt" was read and assigned as column names to the data read above.
3. "subject" txt files from both train and test folders were read, as they represent the subjects ID.
4. "y" txt files from both train and test folders were read, as they represent the activity performed.
5. "subject", "y", and data tables are binded together to form the complete table.

##Subset Data
This part is about subsetting the data to only the data pertaining to mean and standard deviation.

It is done using dplyr, by using the select() function, to choose only the columns that contains the words,
"mean", "std", but not "meanFreq". The Subject and Activity columns are selected too, as they are needed for
the next part of the project.

##Replacing Activity Names
This part is about replacing the activity numbers ( 1- 6) in the activity column into the activity they represent.

This is done by performing a loop through the length of the activity list, then subsetting the data table to
the rows that corresponds to the activity number, and replacing the number with the string of the activity.

##Replacing Column Names
This part is about replacing the column names with a clearer description.

By using gsub, various unintuitive parts of column names were substituted with more readable and concise description.

For example,

1.  tBodyAcc-mean()-X		   	- time of body acceleration mean x axis
2.  tBodyAcc-mean()-Y		   	- time of body acceleration mean y axis
3.  tBodyAcc-mean()-Z		  	- time of body acceleration mean z axis
4.  tBodyAcc-std()-X		  	- time of body acceleration standard deviation x axis
5.  tBodyAcc-std()-Y		  	- time of body acceleration standard deviation y axis
6.  tBodyAcc-std()-Z		  	- time of body acceleration standard deviation z axis

With that, the tidying of the data is now complete.

##Part 5

A data table consisting of the average of each variable for each activity and each subject was created using dplyr.

The data table is then written onto a txt file.
