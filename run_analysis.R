library(dplyr)
setwd("C:/Users/Eric BAUDON/Desktop/Nouveau dossier")


#1.Creation of a download folder and an Url for downloading files"
if (!file.exists("data")){dir.create("Data")}
Url<-"https://raw.githubusercontent.com/ericbaudon/Project_Getting-and-Cleaning-Data/master/UCI%20HAR%20Dataset/"


#2.Download and Read test and train data from diverse Txt files"
### Data from subject_test.txt
download.file(paste(Url,"test/subject_test.txt",sep=""),destfile="./Data/subject_test.txt")
subject_test<-read.table("./Data/subject_test.txt")
### Data from y_test.txt
download.file(paste(Url,"test/y_test.txt",sep=""),destfile="./Data/y_test.txt")
y_test<-read.table("./Data/y_test.txt")
### Data from X_test.txt
download.file(paste(Url,"test/X_test.txt",sep=""),destfile="./Data/X_test.txt")
X_test<-read.table("./Data/X_test.txt")
### Combine in single dataframe and remove older downloaded files from Global Environment
test_data<-cbind.data.frame(subject_test,y_test,X_test)
rm(subject_test,y_test,X_test)

### Data from subject_train.txt
download.file(paste(Url,"train/subject_train.txt",sep=""),destfile="./Data/subject_train.txt")
subject_train<-read.table("./Data/subject_train.txt")
### Data from y_train.txt
download.file(paste(Url,"train/y_train.txt",sep=""),destfile="./Data/y_train.txt")
y_train<-read.table("./Data/y_train.txt")
### Data from X_train.txt
download.file(paste(Url,"train/X_train.txt",sep=""),destfile="./Data/X_train.txt")
X_train<-read.table("./Data/X_train.txt")
### Combine in single dataframe and remove older downloaded files from Global Environment
train_data<-cbind.data.frame(subject_train,y_train,X_train)
rm(subject_train,y_train,X_train)


#3.Bind both sets to create on global data set and rename columns as per feature.txt
### Global data set
global_data<-rbind(test_data,train_data)
rm(test_data,train_data)
### Rename columns
download.file(paste(Url,"features.txt",sep=""),destfile="./Data/features.txt")
variables<-read.table("./Data/features.txt")
colnames<-c("subject","activity",as.character(variables[,2]))
colnames<-sub("\\()","",tolower(colnames))
names(global_data)<-colnames


#4.Extract from dataset only variables with means and standard deviation and remove old global_data
mean_vector<-grep("mean",names(global_data))
std_vector<-grep("std",names(global_data))
subset_vector<-c(1,2,mean_vector,std_vector)
subset_data<-subset(global_data,select=subset_vector)
rm(global_data)

#5.Create the clean dataset with activity names instead of numbers
###Download activity data.frame
download.file(paste(Url,"activity_labels.txt",sep=""),destfile="./Data/activity_labels.txt")
activity<-read.table("./Data/activity_labels.txt")
###Rename activities in clean dataset and remove old subset_data useless
clean_data<-subset_data
for (i in 1:6){clean_data[clean_data$activity==i,2]<-as.character(activity[i,2])}
rm(subset_data)

#6.Create the final and tidy dataset with averages,write the table to Data folder and remove old clean_data
final_dataset<-clean_data%>%group_by(activity,subject)%>%summarise_each(funs(mean))
write.table(final_dataset,file="Clean&Tidy.txt",row.name=FALSE)
rm(final_dataset,clean_data,activity,variables,Url,colnames,i,mean_vector,std_vector,subset_vector)
