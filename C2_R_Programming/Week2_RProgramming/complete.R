complete <- function(directory, id = 1:332) {
        newdf <- data.frame(Date=as.Date(character()),sulfate=double(),nitrate=double(),ID=integer())
        summdf <- data.frame(id=integer(), nobs=integer())
        for(i in id) {
                if(i>0&i<10) {filename <- paste(directory,"/00",i,".csv",sep = "")}
                else if(i>9&i<100) {filename <- paste(directory,"/0",i,".csv",sep = "")}
                else if(i>99&i<333){filename <- paste(directory,"/",i,".csv",sep = "")}
                else {print("Error: file not found. Try values between 1-332.")
                        # how to end the function
                }
                currentdf <- read.csv(filename, header = T)
                nobs <- nrow(currentdf[complete.cases(currentdf),])
                id <- i
                nobsdf <- data.frame(id,nobs)
                summdf <- rbind(summdf,nobsdf)
        }
        summdf
}
