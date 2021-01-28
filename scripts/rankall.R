outcome <- "pneumonia"
num <- 1
pathfile <- "Data/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv"

rankall <- function(outcome, num = 1){
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
  
  if (is.character(num)){
    if (num == "worst"){
      num <- length(state_data[,1])
    }else if(num == "best"){
      num <- 1
    }else{
      stop("invalid input")
    }
  }else if (num >length(state_data[[1]])){
    return(NA)
  }
  outcome <- check.out(outcome)
  outcome_data <- read.csv(pathfile)
  data.clean <- data.frame(
    Hospital.Name = outcome_data$Hospital.Name,
    State = outcome_data$State,
    Rate = outcome_data[[outcome]]
  )
  data.clean <- data.clean[order(data.clean$Hospital.Name),]
  data.list <- split(data.clean$Hospital.Name, data.clean$State)
  state_data <-  split(data.clean$Rate, data.clean$State)
  
  #get the sorted index for all states
  idx <- lapply(state_data, order)
  ranked.idx <- sapply(idx, function(x) x[num])
  vals <- mapply(function(x,idx){as.character(x[idx]) }, data.list, ranked.idx)
  results <- data.frame(hospital= vals, states = names(vals))
  results
}