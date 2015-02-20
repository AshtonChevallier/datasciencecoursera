
mainDir <- getwd()
subDir <- "SamsungData"

if (!file.exists(subDir)){
    print("Creating Subdirectory...")
    dir.create(file.path(mainDir, subDir))
} else {
    print("Subdirectory Exists.")
}

if (!file.exists("ZipData")){
    print("Downloading File...")
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile ="ZipData")
} else {
    print("ZipData already exists")
}

ZipData = "ZipData"
if(!file.exists(paste(subDir,"/UCI HAR Dataset", sep =""))){
    print("Unzipping...")
    unzip(ZipData,exdir=subDir)
} else {
    print("Already Unzipped")
}

#Load Labels and Features
labels <- read.table("SamsungData/UCI Har Dataset/activity_labels.txt")
features <- read.table("SamsungData/UCI Har Dataset/features.txt")

#Load test and training Y data, combine, then remove extra from memory
ytest <-read.table("SamsungData/UCI Har Dataset/test/Y_test.txt")
ytrain <-read.table("SamsungData/UCI Har Dataset/train/Y_train.txt")
y <- rbind(ytest,ytrain)
rm(ytest,ytrain)

#Load test and training X data, combine, then remove extra from memory
xtest <-read.table("SamsungData/UCI Har Dataset/test/X_test.txt")
xtrain <-read.table("SamsungData/UCI Har Dataset/train/X_train.txt")
x <- rbind(xtest,xtrain)
rm(xtest,xtrain)

#Load test and training subject data, combine, then remove extra from memory
strain <-read.table("SamsungData/UCI Har Dataset/train/subject_train.txt")
stest <-read.table("SamsungData/UCI Har Dataset/test/subject_test.txt")
s <- rbind(stest,strain)
rm(stest,strain)

# Get Length of Observations to enter IDs to ensure correct matches when merging data
IDs <- 1:length(y[,1])

#Rename X labels
names(x) <- features[,2]

#Extract X Labels with mean or std observation; excluding meanFreq obeservations
newNames <- n <-(grepl("mean",names(x)) & !grepl("Freq",names(x)) | grepl("std",names(x)))
x <- x[,newNames]

#Insert ID variables
x$ID <- IDs
y$ID <- IDs
s$ID <- IDs

#Rename Subject Labels
s<-rename(s,Subject=V1)

#Merge and Rename Y Labels

tidyData <- merge(y,labels, by.x="V1",by.y="V1")
tidyData <- rename(tidyData,Activity_ID=V1,Activity=V2)

#Add Subject Data
tidyData <- merge(tidyData,s, by.x="ID",by.y="ID")
                 
#Add X Data
tidyData <- merge(tidyData,x, by.x="ID",by.y="ID")

#Use Group By and summarize to add means
tidyMeans <- tidyData %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))

#Trim Uneeded Columns
tidyMeans <- tidyMeans[,c(1:2,5:70)]
tidyData <- tidyData[,3:70]


