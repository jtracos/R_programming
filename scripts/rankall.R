outcome <- "pneumonia"
num <- 1
pathfile <- "Data/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv"

rankall <- function(outcome, num = "best"){
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
  
  outcome <- check.out(outcome)
  ## reading file
  outcome_data <- read.csv(pathfile,colClasses = "character")
  outcome_data[[outcome]] <- as.numeric(outcome_data[[outcome]])#to numeric
  ## remove incomplete data
  selected <-!is.na(outcome_data[[outcome]])
  outcome_data <- outcome_data[selected,]
  ##get our target variables
  data.clean <- data.frame(
    Hospital.Name = outcome_data$Hospital.Name,
    State = outcome_data$State,
    Rate = outcome_data[[outcome]]
  )
  ## order data
  data.clean <- data.clean[order(data.clean$Hospital.Name),]
  ## split the data names
  data.list <- split(data.clean$Hospital.Name, data.clean$State)
  ## split target variable
  state_data <-  split(data.clean$Rate, data.clean$State)
  ##check number
  if (is.character(num)){
    if (num == "worst"){
      num <- sapply(state_data, length)
    }else if(num == "best"){
      num <- 1
    }else{
      stop("invalid input")
    }
  }else if (num >max(sapply(state_data, length))){
    return(NA)
  }
  
  #get the sorted index for all states
  idx <- lapply(state_data, order)
  #ranked.idx <- sapply(idx, function(x) x[num])
  ##map the vector values inside a list
  ranked.idx <- mapply(function(x,id) x[id], idx,num)
  ## getting the hospital names
  vals <- mapply(function(x,idx){as.character(x[idx]) }, data.list, ranked.idx)
  results <- data.frame(hospital= vals, states = names(vals))
  results
  ##remove empty entries
  results[complete.cases(results),]
}