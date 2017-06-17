best <- function(state, outcome) {
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
        
        ## Return hospital name in that state with lowest 30-day death rate
        workingdf <- workingdf[complete.cases(workingdf),]
        min_mortality <- workingdf[workingdf[,2]==min(workingdf[,2]),]
        min_mortality <- min_mortality[order(min_mortality$Hospital.Name),]
        besthosp <- head(min_mortality$Hospital.Name,1)
        print(besthosp)
}
