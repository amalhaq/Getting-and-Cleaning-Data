#Reading data into the R console, 8 different data frames.
if(!file.exists("./projectdata")){dir.create("./projectdata")}
fileURL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="./projectdata/Data.zip",method="curl")
unzip(zipfile="./projectdata/Data.zip",exdir="./projectdata")
ytest<- read.table("projectdata/UCI HAR Dataset/test/y_test.txt", header=FALSE)
xtest<- read.table("projectdata/UCI HAR Dataset/test/X_test.txt", header=FALSE)
subtest<- read.table("projectdata/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
ytrain<- read.table("projectdata/UCI HAR Dataset/train/y_train.txt", header=FALSE)
xtrain<- read.table("projectdata/UCI HAR Dataset/train/X_train.txt", header=FALSE)
subtrain<- read.table("projectdata/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
columnnames<- read.table("projectdata/UCI HAR Dataset/features.txt", header=FALSE)
activitynames<- read.table("projectdata/UCI HAR Dataset/activity_labels.txt", header=FALSE)

#merging the test and train data tables that we have provided handles for from 'X', 'y' and
#'subject' files under workingdirectory/projectfolder/UCI HAR Dataset.
mergeX<- rbind(xtrain, xtest)  #merging X files
colnames(mergeX)<- columnnames[,2] # provinding column headers for merged X
mergey<- rbind(ytrain, ytest) # merging y files
colnames(mergey)<- c("activity") # providing column header for merged y
mergesub<- rbind(subtrain, subtest) #merging subset files
colnames(mergesub)<- c("subject") # providing column header for merged subset
mergeall<- cbind(mergeX, mergesub, mergey) # merging x, y, subset data frames

#extracting only columns that provide mean and standard deviations, and the columns 
#that give information on activity and subject
subsetmerge<- mergeall[, grep("mean\\(\\)|std\\(\\)|activity|subject", colnames(mergeall))]

#provide descriptive activity names in "activity" column so that number 1-6 
#are replaced with activities like walking standaing sitting laying etc.
subsetmerge$activity <- factor(subsetmerge$activity, 1:6, as.character(activitynames$V2))

#providing informative and descriptive variable names (column header) by replacing 
#abbreviation and unwanted characters.
colnames(subsetmerge)<-gsub("^tBody", "timeBody", colnames(subsetmerge))
colnames(subsetmerge)<-gsub("^tGravity", "timeGravity", colnames(subsetmerge))
colnames(subsetmerge)<-gsub("^fBody|^fBodyBody", "frequencyBody", colnames(subsetmerge))
colnames(subsetmerge)<-gsub("Acc", "Acceleration", colnames(subsetmerge))
colnames(subsetmerge)<-gsub("Gyro", "Gyroscope", colnames(subsetmerge))
colnames(subsetmerge)<-gsub("Mag", "Magnitude", colnames(subsetmerge))
colnames(subsetmerge)<-gsub("\\(\\)", "", colnames(subsetmerge))

#creating independent data frame to average 66 measurements for each of the 6 activities 
# and for each of the 30 subjects.
Groupmerge<- group_by(subsetmerge, subject, activity)
ResultDF<-  summarise_each(Groupmerge, funs(mean))

#END.
                                  