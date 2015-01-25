# Get-Clean-Coursera
Course project for Get &amp; Clean Coursera 

INTRODUCTION

Creating one R script called "run_analysis.R" that does the following. 

1- Merges the training and the test sets to create one data set.

2- Extracts only the measurements on the mean and standard deviation for each measurement. 

3- Uses descriptive activity names to name the activities in the data set

4- Appropriately labels the data set with descriptive variable names. 

5- From the data set in step 4, creates a second, independent tidy data set with the 
average of each variable for each activity and each subject.

ANALYSIS PROCEDURE

Following is a description of how the script "run_analyis.R" works:

1 - Merges the training and the test sets to create one data set
- Set the right directory. The working directory should be set at the same level 
as the Samsung dataset "UCI_Har_Dataset"
- Load data into R
- Naming the columns. Do not name the X_test and X_train because the feature texts 
is too long, now using V1, V2, ...
- Combining by column into a data frames for the test set using "cbind"
- Naming and combining into a data frames for the training set
- Combining by row the df_train and df_test into a big data frame using "rbind"

2- Extracts only the measurements on the mean and standard deviation for each measurement. 
- loading the package "dplyr"
- Convert the data frame into a tbl_df using in "dplyr"
- Use select(..) to select all columns that are the measurements on the mean and 
	standard deviation.

3-Uses descriptive activity names to name the activities in the data set
- Read the file "activity_labels.txt into R
- Make the labels confort to R guidelines, for example using "." instead of "_"
- Replace the activity codes into a descriptive names of the activities 
	The way it was handled was just to make a data frame of the activity labels,
		then use the activity code as an index into this data frame to select the 
		correct activity label.The activity label data frame looks like this:

		V1 is the index 
		V2 is the activity text (or label)

			  V1                 V2
			1  1            walking
			2  2   walking.upstairs
			3  3 walking.downstairs
			4  4            sitting
			5  5           standing
			6  6             laying
			
		For each row of the data set, 
			- get the index (or the activity code)
			- from the index, get the label (see the data frame over)
			- replace the index by the label in the original data set			

4- Appropriately labels the data set with descriptive variable names. 
- Make the feature texts confort to R guidelines, for example using "." instead of "-"
- Naming and combine dataset 
- Using "select()" from "dplyr" to select all columns that are the measurements on 
the mean and standard deviation. Now with a descriptive variable names
- Extract the two first columns, "Subject" and "Activity", from the older dataset
- Combine by row to make a new data set with descriptive variable names of the 
measurements 

5- From the data set in step 4, creates a second, independent tidy data set with 
   the average of each variable for each activity and each subject.
- Build again an unnamed dataSet without naming the variable of mean and std columns
 This is because it is easier to call the "mean" function for each columm 
 if the column name is "V1,V2,..."
- Combine to get an unnamed data set except the "subject" and "activity" columns
- Arrange the unamed data set to sort (ascending) first by "Subject" then 
by "Activity". This step might be not necessary
- Using function "group_by()" to group first by subject then by activity
- Calculate the mean value of each variable group by each activity and each subject 

Write the tidy data set to a file in the working directory with row.names = FALSE
