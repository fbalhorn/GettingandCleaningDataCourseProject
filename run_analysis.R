# The following R script creates a neat and tidy dataset according to the task descriptions. I technically do NOT follow the steps 1-5 in specific 
# and individual order. Nevertheless, I end up with a dataset as asked for.

# used package:
library('reshape2')

#############################################################################################
# read Trainingdata:
features<-read.table('features.txt') #load column descriptions
activity_labels<-read.table('activity_labels.txt') #activity descriptions 1-6
subject_train<-read.table('train/subject_train.txt') #load subject<->row information
X_train<-read.table('train/X_train.txt') #load user sensor data for training set
Y_train<-read.table('train/Y_train.txt') #load user sensor data interpretation training set

# read Testdata
subject_test<-read.table('test/subject_test.txt') #load subject<->row information
X_test<-read.table('test/X_test.txt') #load user sensor data for test-set
Y_test<-read.table('test/y_test.txt') #load user sensor data interpretation for test-set


#############################################################################################
#rbind test and training datasets together:
X_all<-rbind(X_test,X_train)
Y_all<-rbind(Y_test,Y_train)
subject_all<-rbind(subject_test,subject_train)

#assign column names for X_all:
names(X_all)<-features[[2]]

#filter column Names to match the requirements from step 2 in the instructions:
X_all_filtered1<-X_all[grep("mean()",names(X_all),fixed = TRUE)]
X_all_filtered2<-X_all[grep("std()",names(X_all),fixed = TRUE)]
X_all_filtered<-cbind(X_all_filtered1,X_all_filtered2)

#name the column for the activities with activity code and replace with activity names:
names(Y_all)<-'activity_code'
for (i in 1:length(activity_labels$V1)){
  Y_all$activity_code[Y_all$activity_code == activity_labels$V1[i]] <- as.character(activity_labels$V2[i])
}

#name the column for the subjects:
names(subject_all)<-'subject_id'

#bind everything together:
XY_all<-cbind(X_all_filtered,Y_all,subject_all) # XY_all now contains all relevant data merged and renamed appropriately


#step 5: creating the independent tidy data set:
character_vector = as.character(names(XY_all[, 1:66])) # specify a vector containing the variables
melt_frame = melt(XY_all, id=c("activity_code","subject_id"), measure.vars=character_vector) # use melt to declare the activity_code and subject_id as id-type fields
tidy_data = dcast(melt_frame, subject_id + activity_code ~ variable, mean)  # tidy_data contains the desired result

names(tidy_data)<-c("activity_code","subject_id",paste(names(tidy_data[3:68]),"_mean",sep='')) # rename column headers to encorporate the mean

write.table(tidy_data,file="tidy_data.txt",row.names=FALSE) # create output file
