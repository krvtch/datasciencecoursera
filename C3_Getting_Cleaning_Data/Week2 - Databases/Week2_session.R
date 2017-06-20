## HDF5 -- HIERARCHICAL DATA FORMAT


source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)

# Creating new hdf5:
created = h5createFile("example.h5") # or use <-
created
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")

h5ls("example.h5")


# Writing to groups:
A = matrix(1:10, nr=5,nc=2)
h5write(A, "example.h5","foo/A")

B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B, "example.h5","foo/foobaa/B")

h5ls("example.h5")

# Write a data set:
df = data.frame(1L:5L,seq(0,1,length.out = 5), c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = FALSE)
h5write(df,"example.h5","df")

h5ls("example.h5")

# Reading your data:
readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readC = h5read("example.h5", "df")

# (Over)writing and reading chunks:
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1)) # writes only on specific elements located by index:list combination
h5read("example.h5","foo/A")
h5read("example.h5","foo/A",index=list(1:3,1)) # read only the elements dictated by index:list


## Webscraping

# Getting data off webpages:
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)

# To parse the above:
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url,useInternalNodes = T)
# root.Node <- xmlRoot(html)
# xmlName(root.Node)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue) # not working anymore
xpathSApply(html, "//td[@class='gsc_a_c']", xmlValue)

# Similar method to parse:
install.packages("httr")
library(httr)
html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText = T)
xpathSApply(parsedHtml, "//title", xmlValue)
xpathSApply(parsedHtml, "//td[@id='col-citedby']", xmlValue) # not working anymore
xpathSApply(parsedHtml, "//td[@class='gsc_a_c']", xmlValue)

# Accessing websites with passwords:
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
names(pg2)

# Using handles:
google = handle("http://google.com")
pg1 = GET(handle = google,path = "/")
pg2 = GET(handle = google,path = "search")


## READING from APIs
myapp = oauth_app("twitter", key = "yourConsumerKeyHere", secret = "yourCOnsumerSecretHere")
sig = sign_oauth1.0(myapp,token = "yourTokenHere", token_secret = "yourTokenSecretHere")
2
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

json1 = content(homeTL) # to extract the JSON data
json2 = jsonlite::fromJSON(toJSON(json1)) # error due to expired token
json2[1,1:4]
