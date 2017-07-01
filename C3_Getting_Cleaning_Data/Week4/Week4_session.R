## Editing Text Variables
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/cameras.csv", mode = 'wb')
camData <- read.csv("./data/cameras.csv")
names(camData)

splitNames = strsplit(names(camData),"\\.")

grep("Alameda",camData$intersection)
grepl("Alameda",camData$intersection)

library(stringr)
nchar("Proles Joseph")
substr("Proles Joseph",1,6)
paste("Proles","Joseph")
paste0("Proles","Joseph")
str_trim("Proles    ")

## Working with Dates

d1 <- date()
class(d1) # it's a character

d2 <- Sys.Date()
class(d2) # it's a date!
