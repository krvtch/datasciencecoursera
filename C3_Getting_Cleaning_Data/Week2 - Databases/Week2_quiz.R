## QUESTION 1

library(httr)
library(httpuv)

oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "a39a4e9067c6c7b1f88f",
                   secret = "b54e2e6863dbdda8898b412fff9cb9d5264befff")

# get authentication credentials; needs httpuv R package
# default web browser open and will prompt you to authenticate
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# load/use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# similarly:
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
repo_list <- content(req)

# select the top of the data:

answer1 <- c() 
for (i in 1:length(repo_list)) {
        repo <- repo_list[[i]]
        if (repo$name == "datasharing") {
                answer1 = repo
                break
        }
}


## QUESTION 2 - 3
install.packages("sqldf")
library(sqldf)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "C:/Users/User/Desktop/Coursera/Course3_Data_Cleaning/Week2 - Databases/acs.csv")
acs <- read.csv("acs.csv")
str(acs)

# will select only the data for the probability weights pwgtp1 with ages less than 50
head(sqldf("select pwgtp1 from acs where AGEP < 50"),10)

# what is the equivalent function to unique(acs$AGEP)
head(sqldf("select distinct AGEP from acs"),10)


## QUESTION 4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)

nchar(htmlCode[c(10,20,30,100)])


## QUESTION 5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", destfile = "C:/Users/User/Desktop/Coursera/Course3_Data_Cleaning/Week2 - Databases/cpc_fortran.for")

# let's explore the data format first
lines <- readLines("cpc_fortran.for", n=10) # there are 4 lines of headers not needed
nchar(lines[5]) # to know the width for each column
cpc <- read.fwf("cpc_fortran.for",skip = 4, widths = c(10,9,4,9,4,9,4))
sum(cpc[,4])
