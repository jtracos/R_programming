pathfile <- "Data/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv"
#outcome_data <- read.csv(pathfile, colClasses = "character")
#head(outcome)
#outcome[,11] <- as.numeric(outcome[,11])
#hist(outcome[,11])

best <- function(state, outcome) {
  ## Read outcome data
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  outcome_data <- read.csv(pathfile, colClasses = "character")
  ## Check that state and outcome are valid
  check.out <- function(outcome){
    ## function to chech the outcome entry
    ## if not correct, it stops
    if(outcome =="heart attack"){
      label <-"Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    }else if(outcome =="heart failure"){
      label <- "Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    }else if(outcome =="pneumonia"){
      label <- "Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    }else{
      stop(paste("outcome:",outcome, "is not a valid entry", sep = " "))
    }
    label
  }
  
  if(!(state %in% outcome_data$State)) {#if state is not present, stop
    stop(paste("State:", state, "is not present", sep=" "))
  }
  ##Get the colname for the outcome
  outcome_label <- check.out(outcome)
  ## get data for state
  state_data <-  split(outcome_data, outcome_data$State)[[state]]
  ## get the outcome data
  outcome_data <- state_data[[outcome_label]]
  outcome_data <- as.numeric(outcome_data)
  hospitals <- state_data$Hospital.Name
  ##removing NA
  selected <- !is.na(outcome_data)
  outcome_data <- outcome_data[selected]
  hospitals <- hospitals[selected]
  ## find where is the best
  best <- outcome_data == min(outcome_data)
  ## get the best hospitals
  all <- hospitals[best]
  ## sort hospital
  if (length(all)>=1){
    all <- sort(all)
    ## return the first
    return(all[1])
  }
  return(NA)
}

