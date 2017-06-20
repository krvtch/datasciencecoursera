## QUESTION 1-2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",destfile = "C:/Users/User/Desktop/Coursera/Course3_Data_Cleaning/Week1/data.csv")

maindf <- read.csv("data.csv")
head(maindf)
valonly <- maindf$VAL[complete.cases(maindf$VAL)]
table(valonly)

summary(maindf$FES)


## QUESTION 3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",destfile = "C:/Users/User/Desktop/Coursera/Course3_Data_Cleaning/Week1/naturalgas.xlsx")
install.packages("xlsx")
install.packages("rJava")

library(rJava)
library(xlsx)

Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_131')

dat <- read.xlsx("naturalgas.xlsx", rowIndex = c(18:23), colIndex = c(7:15), sheetIndex = 1)
sum(dat$Zip*dat$Ext,na.rm=T)


## QUESTION 4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", destfile = "C:/Users/User/Desktop/Coursera/Course3_Data_Cleaning/Week1/baltimore_resto.xml")
install.packages("XML")

library(XML)

# fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse("baltimore_resto.xml", useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
# zipcodes <- xmlSApply(rootNode,xmlValue)
zipcodes <- xpathSApply(rootNode,"//zipcode",xmlValue)
countzip <- table(zipcodes)

# QUESTION 5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "C:/Users/User/Desktop/Coursera/Course3_Data_Cleaning/Week1/idaho.csv")
install.packages("data.table")
library(data.table)

DT <- fread("idaho.csv")
DT$pwgtp15

a <- system.time(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15))
b <- system.time(DT[,mean(pwgtp15),by=SEX]) # fastest
c <- system.time(tapply(DT$pwgtp15,DT$SEX,mean))
d <- system.time(rowMeans(DT)[DT$SEX==1], rowMeans(DT)[DT$SEX==2])
e <- system.time(mean(DT$pwgtp15,by=DT$SEX)) # incorrect, not categorized by m/f
f <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))

