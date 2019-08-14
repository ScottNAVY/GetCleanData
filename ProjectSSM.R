WD1<-"C:/Users/mclea/Desktop/DataScienceR/UCI HAR Dataset"
setwd(WD1)

#get locations of all the data
#for bonus points, i could use the text screening code to ID the files i want, but i know the order,so it's unecessary 
files.list<-list.files(full.names = TRUE)

test.files<-list.files(files.list[7], full.names = TRUE)
signals.test<-list.files(test.files[1],full.names = TRUE)

subject.test<-fread(test.files[2])
X.test<-fread(test.files[3],data.table = TRUE)
Y.test<-fread(test.files[4],data.table = TRUE)
#add index
Y.test$Data_Source<-"Test"

train.files<-list.files(files.list[8], full.names = TRUE)
signals.train<-list.files(train.files[1],full.names = TRUE)



subject.train<-fread(train.files[2])
X.train<-fread(train.files[3], data.table = TRUE)
Y.train<-fread(train.files[4], data.table = TRUE)
#Add an index
Y.train$Data_Source <- "Train" 


#there are 561 variables, extract the names and then only extract what we need
  features <- read.table(files.list[2], col.names = c("num","formulas"))

##start building data frame(s)
 
 
  Project<- data.frame()
  Project<-rbind(X.test,X.train)
  
  #now we remove the irrelevant data (using the relevant vector didn't seem to work)
  Project<-Project[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202)]
  #let's add the data labels now, before adding the Y data. 
  Old_Names<-c("V1","V2","V3","V4","V5","V6","V41","V42","V43","V44","V45","V46","V81","V82","V83","V84","V85","V86","V121","V122","V123","V124","V125","V126","V161","V162","V163","V164","V165","V166","V201","V202")
  
  
  relevant<-c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202)
  New_Names<- as.vector(features[relevant,2])
  
  for (i in 1:32) {
    colnames(Project)[colnames(Project)==Old_Names[i]] <- New_Names[i]   }
  
  
  Cols<-rbind(Y.test,Y.train)
  
  #now I need to replace the #'s in Y column with the activity names. 
  #gsub targeting a specific column
  Cols$V1<-gsub("1","Walking",Cols$V1)
  Cols$V1<-gsub("2","Walking_Upstairs",Cols$V1)
  Cols$V1<-gsub("3","Walking_Downstairs",Cols$V1)
  Cols$V1<-gsub("4","Sitting",Cols$V1)
  Cols$V1<-gsub("5","Standing",Cols$V1)
  Cols$Activity<-gsub("6","Laying",Cols$V1)
  #this is a roundabout way of renaming a column
  Cols<-Cols[,-1]
  
  subjects<-rbind(subject.test,subject.train)
  Cols$Subject<-subjects
  
  
  Project<-cbind(Cols,Project)
  
  submission<-aggregate(Project, FUN = mean, by = list(Project$Activity,Project$Subject))