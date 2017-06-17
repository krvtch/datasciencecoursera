rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        outcomedf <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Check if the state is valid or not
        uniqstate <- unique(outcomedf$State[outcomedf$State==state])
        if(length(uniqstate)==0) {stop("invalid state")}
        outcomedf <- outcomedf[outcomedf$State == state,]
        
        ## Select which outcome, and check if outcome is valid or not
        {if(outcome=="heart attack") {
                outcomedf[, 11] <- as.numeric(outcomedf[, 11])
                workingdf <- subset(data.frame(outcomedf), select = c(2,11))
        }
        else if(outcome=="heart failure") {
                outcomedf[, 17] <- as.numeric(outcomedf[, 17])
                workingdf <- subset(data.frame(outcomedf), select = c(2,17))
        }
        else if(outcome=="pneumonia") {
                outcomedf[, 23] <- as.numeric(outcomedf[, 23])
                workingdf <- subset(data.frame(outcomedf), select = c(2,23))
        }
        else {stop("invalid outcome")}}
        
        workingdf <- workingdf[complete.cases(workingdf),]
        workingdf <- workingdf[order(workingdf[,2],workingdf[,1]),]
        
        {if(num=="best") {nthhosp <- head(workingdf$Hospital.Name,1)
                hospname <- nthhosp
        }
        else if(num=="worst") {
                nthhosp <- subset(workingdf,workingdf[,2]==max(workingdf[,2]))
                worsthosp <- head(nthhosp$Hospital.Name,1)
                hospname <- worsthosp
        }
        else if(num>max(nrow(workingdf))) {
                hospname <- NA
        }
        else {
                nthhosp <- head(workingdf,num)
                hospname <- tail(nthhosp$Hospital.Name,1)
        }}
        ## Return hospital name in that state with the given rank 30-day death rate
        hospname
}
