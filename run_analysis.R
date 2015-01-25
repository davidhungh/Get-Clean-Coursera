#################################################################################
#
# Coursera : Get and Cleaning data / Course project
# Date     : 25 jan. 2015
# Author   : Hung Buu Huynh
# 
#################################################################################
#
# 1 - Merges the training and the test sets to create one data set
#
#################################################################################
#
# Set the right directory
# The working directory should be set at the same level as "UCI_Har_Dataset"
# 
# For example my working directory is:
# setwd("~/Documents/Dropbox/WorkSpace/DtaScience/B-GetClean/data/UCI_HAR_Dataset")

#
# Load data into R
#
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
features <- read.table("./features.txt")

#
# Naming the columns
# Do not name the X_test/X_train because the feature texts is too long, 
# now using V1, V2, ...
#
names(subject_test) = c("Subject")
names(y_test) = c("Activity")

#
# Combining by column into a data frames for the test set using "cbind"
#
df_test <- cbind(y_test,X_test)
df_test <- cbind(subject_test,df_test)

#
# Naming and combining into a data frames for the training set
#
names(subject_train) = c("Subject")
names(y_train) = c("Activity")
df_train <- cbind(y_train,X_train)
df_train <- cbind(subject_train,df_train)

#
# Combining by row the df_train and df_test into a big data frame using "rbind"
#
df = rbind(df_test,df_train)

##############################################################################################
#
# 2- Extracts only the measurements on the mean and standard deviation for each measurement. 
#
##############################################################################################

# loading the package "dplyr"
library("dplyr")

# Convert the data frame into a tbl_df using in "dplyr"
mydf <- tbl_df(df)

# Use select(..) to select all columns that are the measurements on the mean and standard deviation.
mean.std.mydf = select(mydf, 1,2,V1:V6,V41:V46,V81:V86,V121:V126,V161:V166,V201:V202,V214:V215,V227:V228,V240:V241,V253:V254,V266:V271,V294:V296,V345:V350,V373:V375,V424:V429,V452:V454,V503:V504,V513,V516,V517,V526,V529,V530,V539,V542,V543,V552,V555:V561)

##############################################################################################
#
# 3-Uses descriptive activity names to name the activities in the data set
#
##############################################################################################

activity.labels <- read.table("./activity_labels.txt")

# make the labels confort to R guidelines
activity.labels[,2] <- sub("_",".",activity.labels[,2])

nof_row = nrow(mean.std.mydf)
for (i in 1:nof_row){ 
  index <- mean.std.mydf[i,2]
  label <- activity.labels[index,2]
  mean.std.mydf[i,2] <- sub(index,label,mean.std.mydf[i,2]) 
}

# A more compact form is also work:
# for (i in 1:nof_row){ 
#  mean.std.mydf[i,2] <- activity.labels[mean.std.mydf[i,2], 2] }

##############################################################################################
#
# 4- Appropriately labels the data set with descriptive variable names. 
#
##############################################################################################

features[,2] <- gsub("-",".",features[,2])

# Take care of the unamed X_test and X_train for later
X_test_names <- X_test
X_train_names <- X_train

features.names <- features[,2]
names(X_test_names) <- features.names
names(X_train_names) <- features.names

# Combine to a big data set by row
Xdf = rbind(X_test_names,X_train_names)
myXdf = tbl_df(Xdf)
mean.std.myXdf = select(myXdf,1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,513,516,517,526,529,530,539,542,543,552,555:561)
subject.activity <- select(mean.std.mydf,1,2)
dataSet = cbind(subject.activity, mean.std.myXdf)

##############################################################################################
#
5- From the data set in step 4, creates a second, independent tidy data set with 
   the average of each variable for each activity and each subject.
#
##############################################################################################

# Build again an unnamed dataSet without naming the variable of mean and std columns
# This is because it is easier to call the "mean" function for each columm if the column name is "V1,V2,..."

udata.df = rbind(X_test,X_train)
my.udata.df = tbl_df(udata.df)
mean.std.my.udata.df = select(my.udata.df,1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,513,516,517,526,529,530,539,542,543,552,555:561)

# Combine to get an unnamed data set except the "subject" and "activity" columns
udataSet = cbind(subject.activity, mean.std.my.udata.df)

# Arrange the unamed data set to sort (ascending) first by "Subject" then by "Activity"
arrange.udataSet <- arrange(udataSet,Subject,Activity)

# group by subject then activity
by_subject_activity <- group_by(arrange.udataSet,Subject,Activity)

# Calculate the mean value of each variable group by each activity and each subject 
tidyData <- summarize(by_subject_activity,
                      mean(V1),
                      mean(V2),
                      mean(V3),
                      mean(V4),
                      mean(V5),
                      mean(V6),                     
                      mean(V41),
                      mean(V42),                     
                      mean(V43),
                      mean(V44),
                      mean(V45),
                      mean(V46),                     
                      mean(V81),
                      mean(V82),
                      mean(V83),
                      mean(V84),
                      mean(V85),
                      mean(V86),                       
                      mean(V121),
                      mean(V122),
                      mean(V123),
                      mean(V124),
                      mean(V125),
                      mean(V126),                     
                      mean(V161),
                      mean(V162),
                      mean(V163),
                      mean(V164),
                      mean(V165),
                      mean(V166),                     
                      mean(V201),
                      mean(V202),                     
                      mean(V214),
                      mean(V215),                     
                      mean(V227),
                      mean(V228),                   
                      mean(V240),
                      mean(V241),                      
                      mean(V253),
                      mean(V254),                      
                      mean(V266),
                      mean(V267),
                      mean(V268),
                      mean(V269),
                      mean(V270),
                      mean(V271),                     
                      mean(V294),
                      mean(V295),
                      mean(V296),                     
                      mean(V345),
                      mean(V346),
                      mean(V347),
                      mean(V348),
                      mean(V349),
                      mean(V350),                     
                      mean(V373),
                      mean(V374),
                      mean(V375),                     
                      mean(V424),
                      mean(V425),
                      mean(V426),
                      mean(V427),
                      mean(V428),
                      mean(V429),                     
                      mean(V452),
                      mean(V453),
                      mean(V454),                     
                      mean(V503),
                      mean(V504),                     
                      mean(V513),
                      mean(V516),
                      mean(V517),
                      mean(V526),                    
                      mean(V530),
                      mean(V539),
                      mean(V542),
                      mean(V543),                      
                      mean(V552),
                      mean(V555),
                      mean(V561)                      
)

# write the tidy data set to a file in the working directory
write.table(tidyData, file = "myTidyData.txt", row.names= FALSE)





