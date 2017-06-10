pollutantmean <- function(directory, pollutant, id = 1:332) {
        newdf <- data.frame(Date=as.Date(character()),sulfate=double(),nitrate=double(),ID=integer())
        for(i in min(id):max(id)) {
                if(i>0&i<10) {filename <- paste(directory,"/00",i,".csv",sep = "")}
                else if(i>9&i<100) {filename <- paste(directory,"/0",i,".csv",sep = "")}
                else if(i>99&i<333){filename <- paste(directory,"/",i,".csv",sep = "")}
                else {print("Error: file not found. Try values between 1-332.")
                        # how to end the function
                        }
                currentdf <- read.csv(filename, header = T)
                newdf <- rbind(newdf,currentdf)
                i = i+1
        }
        if(pollutant=="sulfate"){ans <- mean(newdf$sulfate[!is.na(newdf$sulfate)])}
        else if(pollutant=="nitrate"){ans <- mean(newdf$nitrate[!is.na(newdf$nitrate)])}
        else {print("Error: ",pollutant," not found")
                    # end the function
        }
        ans
}
