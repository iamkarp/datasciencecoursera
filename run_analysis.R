require(reshape2)

library(reshape2)

X_train<-read.delim("train/X_train.txt",header=FALSE, sep="")
y_train<-read.delim("train/y_train.txt",header=FALSE, sep="")
X_test<-read.delim("test/X_test.txt",header=FALSE, sep="")
y_test<-read.delim("test/y_test.txt",header=FALSE, sep="")
subject_train<-read.delim("train/subject_train.txt",header=FALSE,sep="")
subject_test<-read.delim("test/subject_test.txt",header=FALSE,sep="")
activity_labels<-read.delim("activity_labels.txt",header=FALSE, sep="")

TrainAll<-cbind(subject_train,y_train,X_train)
TestAll<-cbind(subject_test,y_test,X_test)
TestTrainAll<-rbind(TestAll,TrainAll)




features<-read.delim("features.txt",header=FALSE,sep="")
features<-features[,2]
features<-append("activity_code",as.character(features))
features<-append("subject",as.character(features))
names(TestTrainAll)<-features

meanstdonly<-grepl("[Mm]ean",features)|grepl("std",features)|grepl("^subject",features)|grepl("^activity_code",features)

TestTrainMeanStd<-TestTrainAll[,meanstdonly]

subjectactivity<-TestTrainAll$subject*100+TestTrainAll$activity_code
subjectactivities<-unique(subjectactivity)


for (i in 1:length(subjectactivities)) {
  if (i==1) {
    TestTrainMeanStd2<-colMeans(TestTrainMeanStd[subjectactivity==subjectactivities[i],])

  } else {
    TestTrainMeanStd2<-rbind(TestTrainMeanStd2,colMeans(TestTrainMeanStd[subjectactivity==subjectactivities[i],]))
    
  }
}
  
TestTrainAll$activity_code<-sub("1",activity_labels[1,2],TestTrainAll$activity_code)
TestTrainAll$activity_code<-sub("2",activity_labels[2,2],TestTrainAll$activity_code)
TestTrainAll$activity_code<-sub("3",activity_labels[3,2],TestTrainAll$activity_code)
TestTrainAll$activity_code<-sub("4",activity_labels[4,2],TestTrainAll$activity_code)
TestTrainAll$activity_code<-sub("5",activity_labels[5,2],TestTrainAll$activity_code)
TestTrainAll$activity_code<-sub("6",activity_labels[6,2],TestTrainAll$activity_code)


TestTrainMeanStd$activity_code<-sub("1",activity_labels[1,2],TestTrainMeanStd$activity_code)
TestTrainMeanStd$activity_code<-sub("2",activity_labels[2,2],TestTrainMeanStd$activity_code)
TestTrainMeanStd$activity_code<-sub("3",activity_labels[3,2],TestTrainMeanStd$activity_code)
TestTrainMeanStd$activity_code<-sub("4",activity_labels[4,2],TestTrainMeanStd$activity_code)
TestTrainMeanStd$activity_code<-sub("5",activity_labels[5,2],TestTrainMeanStd$activity_code)
TestTrainMeanStd$activity_code<-sub("6",activity_labels[6,2],TestTrainMeanStd$activity_code)
TestTrainMeanStd2<-data.frame(TestTrainMeanStd2)

TestTrainMeanStd2$activity_code<-sub("1",activity_labels[1,2],TestTrainMeanStd2$activity_code)
TestTrainMeanStd2$activity_code<-sub("2",activity_labels[2,2],TestTrainMeanStd2$activity_code)
TestTrainMeanStd2$activity_code<-sub("3",activity_labels[3,2],TestTrainMeanStd2$activity_code)
TestTrainMeanStd2$activity_code<-sub("4",activity_labels[4,2],TestTrainMeanStd2$activity_code)
TestTrainMeanStd2$activity_code<-sub("5",activity_labels[5,2],TestTrainMeanStd2$activity_code)
TestTrainMeanStd2$activity_code<-sub("6",activity_labels[6,2],TestTrainMeanStd2$activity_code)

write.csv(TestTrainMeanStd,file="TestTrainMeanStd.txt")
write.csv(TestTrainMeanStd2,file="TestTrainMeanStd2.txt")  
  
  
