corr <- function(directory, threshold = 0) {
        summdf <- c(corrdf=integer())
        obsdf <- complete(directory)
        obsdf <- obsdf[obsdf$nobs>threshold,]
        for(i in obsdf$id) {
                if(i>0&i<10) {filename <- paste(directory,"/00",i,".csv",sep = "")}
                else if(i>9&i<100) {filename <- paste(directory,"/0",i,".csv",sep = "")}
                else if(i>99&i<333){filename <- paste(directory,"/",i,".csv",sep = "")}
                else {print("Error: file not found. Try values between 1-332.")
                        # how to end the function
                }
                currentdf <- read.csv(filename, header = T)
                currentdf <- currentdf[complete.cases(currentdf),]
                currentcorr <- cor(currentdf$sulfate,currentdf$nitrate)
                corrdf <- (currentcorr)
                summdf <- c(summdf,corrdf)
        }
        summdf
}
