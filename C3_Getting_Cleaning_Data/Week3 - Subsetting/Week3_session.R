## Subsetting
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA

X[,1] # list
X[,"var1"] # list
X[1:2,"var2"] # list
X[(X$var1 <=3 & X$var3 >11),] # df
X[(X$var1 <=3 | X$var3 >15),] # df
X[which(X$var2 > 8),] # df does not deal with NAs

# Sorting
sort(X$var1)
sort(X$var1,decreasing = T)
sort(X$var2,na.last = T)

# Ordering
X[order(X$var1),]
X[order(X$var1,X$var3),] # returns the same unless there are similar var1 values

# Ordering using plyr()
install.packages("plyr")
library(plyr)

arrange(X,var1)
arrange(X,desc(var1))

# Adding rows and columns
X$var4 <- rnorm(5)
Y <- cbind(X,rnorm(5))



## Summarizing Data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

# Look at the data
head(restData,n=3) # default is n=6
tail(restData,n=3)
summary(restData)
str(restData)
quantile(restData$councilDistrict,na.rm = T)
quantile(restData$councilDistrict,probs = c(0.5,0.75,0.9))

# Make table
table(restData$zipCode,useNA = "ifany")
table(restData$councilDistrict,restData$zipCode)

# Check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
colSums(is.na(restData))
all(colSums(is.na(restData))==0)

# Check for values with specific characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213")) # OR
restData[restData$zipCode %in% c("21212","21213"),] # create subset

# Cross tabs (similar to Pivot Table in excel)
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data = DF)

# Flat tables
warpbreaks$replicate <- rep(1:9, len = 54) # create a replicate
xt = xtabs(breaks ~.,data = warpbreaks)
ftable(xt)

# Size of data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData),units = "Mb")



## Creating New Variables
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

# Create index/sequence
s1 <- seq(1,10,by=2)
s2 <- seq(1,10,length=3)
x <- c(1,3,8,25,100); seq(along = x) # uses along to get a seq of same length as variable x

# Subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park","Homeland")
table(restData$nearMe)

# Creating Binary Variables
restData$zipWrong = ifelse(restData$zipCode < 0, T,F)
table(restData$zipWrong,restData$zipCode < 0)

# Creating Categorical Variables
restData$zipGroups = cut(restData$zipCode,breaks = quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups,restData$zipCode)

# Easier Creating Categorical Variables
# below produces factor variables
install.packages("Hmisc")
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4) # g is number of groups
table(restData$zipGroups)

# Similar to above "easier", by using the mutate function
library(Hmisc); library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

# Creating Factor Variables
restData$zcf <- factor(restData$zipCode)
class(restData$zcf)

# Levels of factor variables
yesno <- sample(c("yes","no"),size = 10,replace = T) # random sampling
yesnofac <- factor(yesno,levels=c("yes","no")) # levels argument assigns the order, by default oreding is alphabetical
relevel(yesnofac,ref="yes")
as.numeric(yesnofac) # for use in certain models



## Reshaping Data
