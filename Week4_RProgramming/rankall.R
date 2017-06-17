rankall <- function(outcome, num = "best") {
        ## Read outcome data
        outcomedf <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Select which outcome, and check if outcome is valid or not
        {if(outcome=="heart attack") {
                outcomedf[, 11] <- as.numeric(outcomedf[, 11])
                workingdf <- subset(data.frame(outcomedf), select = c(2,7,11))
        }
        else if(outcome=="heart failure") {
                outcomedf[, 17] <- as.numeric(outcomedf[, 17])
                workingdf <- subset(data.frame(outcomedf), select = c(2,7,17))
        }
        else if(outcome=="pneumonia") {
                outcomedf[, 23] <- as.numeric(outcomedf[, 23])
                workingdf <- subset(data.frame(outcomedf), select = c(2,7,23))
        }
        else {stop("invalid outcome")}}
        
        workingdf <- workingdf[complete.cases(workingdf),]
        workingdf <- workingdf[order(workingdf[,2],workingdf[,3],workingdf[,1]),]
        uniqstate <- unique(workingdf$State)
        
        i <- 0
        for(st in uniqstate) {
                i <- i + 1
                nthhosp <- subset(workingdf,workingdf$State==st)
                names(nthhosp) <- c("hospital","state","rate")
                {if(num=="best") {
                        #arrange
                        nthhosp <- head(nthhosp,1)
                }
                else if(num=="worst") {
                        nthhosp <- subset(nthhosp,nthhosp[,3]==max(nthhosp[,3]))
                        #arrange
                        nthhosp <- head(nthhosp,1)
                }
                else if(num>max(nrow(nthhosp))) {
                        nthhosp <- data.frame(NA, st, NA)
                        names(nthhosp) <- c("hospital","state","rate")
                }
                else {
                        nthhosp <- head(nthhosp,num)
                        nthhosp <- tail(nthhosp,1)
                }}
                
                {if(i==1) {summ <- nthhosp}
                else {summ <- rbind(summ,nthhosp)}}
        }
        summ <- summ[order(summ$state,summ$hospital),]
        summ
}
