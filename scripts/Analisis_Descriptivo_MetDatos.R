getDataClean<- function(dir)
  {
  ## funcion para obtener los valores limpios
  data <- read.csv(dir)
  # count lost data on Ozone
  n_na <- is.na(data$Ozone)
  print("# NA on Ozone Attr:")
  print(sum(n_na==TRUE))
  # get complete data
  #attach(data)
  cond1 <- data$Ozone>31
  cond2 <- data$Temp>90
  #condition to apply
  good <- cond1 && cond2
  return( quiz_data[good,])
}

getDatabyMonth <- function(dir, month)
  {
  data <- read.csv(dir)
  #attach(data)
  idx <- data$Month == month
  return(data[idx,])
}

showResults<-function(data)
  {
  print("summary of selected data:")
  print(summary(data))
}


path <- "Data/hw1_data.csv"
data_month6 <- getDatabyMonth(path,month = 6)

data_month5 <- getDatabyMonth(path,month = 5)
print("month : 6")
showResults(data_month6)
print("month : 5")
showResults(data_month5)
