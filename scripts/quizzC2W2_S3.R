corr <- function(directory, threshold = 0){
  file_names <- list.files(directory)
  corrc<- c()
  old.dir <- getwd()
  setwd(directory)
  for( idx in 1:length(file_names)){
    df <- read.csv(file_names[idx])
    filtered <-complete.cases(df)
    if (sum(filtered) >= threshold){
      df <- df[filtered,]
      ccoef <- cor(df[["nitrate"]],df[["sulfate"]])
      corrc <- c(corrc, ccoef)
    }
  }
  setwd(old.dir)
  return(corrc)
}
path = "Data/specdata"
#df <- corr(path,threshold = 150)