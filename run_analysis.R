##use library readr, dplyr, stringr
##read in test subject file and add column names
test_sub<- read.delim("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "\t", dec = ".")
test_sub <- cbind(test_sub, "test subject")
names(test_sub)<-c("subject", "typeofsubject")

##Read in activity type data file and add column names
activity<- read.delim("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "\t", dec = ".")
names(activity)<-"activity"

## Read in activity labels file 
activitylabels<-read.delim("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "\t", dec = ".")

## Read in the actual activity test data file
testdata <- read.delim("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", dec = ".")

## Read in features.txt, which will be the labels for activity test data
features <- read.delim("./UCI HAR Dataset/features.txt", header = FALSE, sep = "")
features <- select(features, V2)
features <- as.vector(features[,1])

## Clean up activity file and create a dataframe
activitylabels <-parse_number(as.character(activitylabels[,"V1"]))
activitylabels <-cbind(activitylabels, c("walking", "walkingupstairs", "walkingdownstairs", "sitting", "standing", "laying"))
activitylabels <-as.data.frame(activitylabels)
names(activitylabels) <-c("activityid", "activitylabel")

##Merge the activity and activitylabel files to create actvity file with proper labels
namedactivity<-merge(activity, activitylabels, by.x = "activity", by.y = "activityid")
namedactivity<-select(namedactivity, activitylabel)

## take features and name the testdata columns
names(testdata) <- features

## combine all the data to then create the tidy test data table
mean<-testdata[,grep("mean()", names(testdata))]
std <-testdata[, grep("std", names(testdata))]
mstestdata<-cbind(mean, std)
mstestdata<-cbind(namedactivity, mstestdata)
mstestdata<-cbind(test_sub, mstestdata)


##for the training file
training_sub<- read.delim("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "\t", dec = ".")
training_sub <- cbind(training_sub, "training subject")
names(training_sub)<-c("subject", "typeofsubject")

##Read in activity file
trainingactivity<- read.delim("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "\t", dec = ".")
names(trainingactivity)<-"activity"

##Merge the activity and activitylabel files to create actvity file with proper labels
trainnamedactivity<-merge(trainingactivity, activitylabels, by.x = "activity", by.y = "activityid")
trainnamedactivity<-select(trainnamedactivity, activitylabel)

## Read in training data file
traindata <- read.delim("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", dec = ".")

## take features and name the train data columns
names(traindata) <- features

meantrain<-traindata[,grep("mean()", names(traindata))]
stdtrain <-traindata[, grep("std", names(traindata))]
mstraindata<-cbind(meantrain, stdtrain)
mstraindata<-cbind(trainnamedactivity, mstraindata)
mstraindata<-cbind(training_sub, mstraindata)

##combine test and train data
totaldata <- rbind(mstestdata, mstraindata)

write.table(totaldata, "./total.txt", row.names = FALSE)
##write.csv(totaldata, "./total.csv")
##Extracts the mean and std data
data_summary <- totaldata %>%
    group_by(subject,typeofsubject, activitylabel) %>%
    summarise_each(funs(mean))
##write_csv(data_summary, "./file.csv")
