## QUESTION 1
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if(!file.exists("./quiz")) {dir.create("./quiz")}
download.file(fileUrl1,destfile = "./quiz/microdata.csv", mode = 'wb')
data1 <- read.csv("./quiz/microdata.csv")
str(data1)
ans1 <- strsplit(names(data1),"wgtp")[123]
ans1


## QUESTION 2 - 3
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl2,destfile = "./quiz/gdp.csv", mode = 'wb')
data2 <- read.csv("./quiz/gdp.csv")
head(data2,20)
library(data.table)
data2 <- fread("./quiz/gdp.csv", skip = 4, nrows = 190, select = c(5), col.names = c("Total")) # data.table library
class(data2$Total) # character
data2$Total <- as.numeric(gsub(",","",data2$Total))
class(data2$Total) # numeric
ans2 <- mean(data2$Total)
ans2

data3 <- fread("./quiz/gdp.csv", skip = 4, nrows = 190, select = c(4), col.names = c("countryNames")) # data.table library
ans3.1 <- grep("^United",data3$countryNames)
ans3.1
ans3.2 <- length(ans3.1)
ans3.2

## QUESTION 4
fileUrl4.1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl4.2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl4.1,destfile = "./quiz/FGDP.csv", mode = 'wb')
download.file(fileUrl4.2,destfile = "./quiz/FEDC.csv", mode = 'wb')
data4.1 <- fread("./quiz/FGDP.csv", skip = 4, nrows = 190, select = c(1), col.names = c("CountryCode")) # data.table library
data4.2 <- read.csv("./quiz/FEDC.csv")
mergedDF <- merge(data4.1,data4.2,by = "CountryCode") # baseR library
mergedDF$Special.Notes
grep("[Jj]une",mergedDF$Special.Notes, value = T) # try if there are other mentions of June that are not related to Fiscal End
grep("Fiscal year end: June",mergedDF$Special.Notes, value = T) # try to confirm
ans4 <- length(grep("Fiscal year end: June",mergedDF$Special.Notes))
ans4

## QUESTION 5
# install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
class(sampleTimes) # Date
class(amzn) # xts zoo??
# install.packages("lubridate")
library(lubridate)
yr <- year(sampleTimes)
dy <- weekdays(sampleTimes)
data5 <- data.frame(yr,dy)
ans5.1 <- nrow(data5[data5$yr==2012,])
ans5.1
ans5.2 <- nrow(data5[data5$yr==2012 & data5$dy=="Monday",])
ans5.2