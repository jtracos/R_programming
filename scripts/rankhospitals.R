pathfile <- "Data/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv"
#outcome_data <- read.csv(pathfile, colClasses = "character")
#head(outcome)
#outcome[,11] <- as.numeric(outcome[,11])
#hist(outcome[,11])

rankhospital <- function(state, outcome, num) {
  ## Read outcome data
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  outcome_data <- read.csv(pathfile)
  
  ## Check that state and outcome are valid
  check.out <- function(outcome){
    ## function to chech the outcome entry
    ## if not correct, it stops
    if(outcome =="heart attack"){
      label <-"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    }else if(outcome =="heart failure"){
      label <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    }else if(outcome =="pneumonia"){
      label <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    }else{
      stop(paste("outcome:",outcome, "is not a valid entry", sep = " "))
    }
    label
  }
  ##Get the colname for the outcome
  outcome_label <- check.out(outcome)
  if(!(state %in% outcome_data$State)) {#if state is not present, stop
    stop(paste("State:", state, "is not present", sep=" "))
  }
  ## get data for state
  
  state_data <-  split(outcome_data, outcome_data$State)[[state]]
  ## get the outcome data
  outcome_data <- state_data[[outcome_label]]
  ##removing NA
  selected <- !is.na(outcome_data)
  state_data <- state_data[selected,]
  outcome_data <- outcome_data[selected]
  
  if (is.character(num)){
    if (num == "worst"){
      num <- length(state_data[,1])
    }else if(num == "best"){
      num <- 1
    }else{
      stop("invalid input")
    }
  }else if (num >length(state_data[,1])){
    return(NA)
  }
  
  state_data[[outcome_label]] <- as.numeric(state_data[[outcome_label]])
  
  ## load variables
  state_data <- data.frame(Hospital.Name = state_data$Hospital.Name, Rate = outcome_data)
  
  ##order data based on names
  state_data <- state_data[order(state_data$Hospital.Name),]
  ##Ordering data by rate
  state_data <- state_data[order(state_data$Rate),]
  #state_data$Rank <- 1:length(state_data[,1])
  ##return the name of the ranked num
  as.character(state_data$Hospital.Name[num])
}
