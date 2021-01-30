complete <- function(directory, id=1:332){
  get.NamedFile <- function(index){
    ##this function check # for complet data for the id
    if(id[index]<10){
      file_name <- paste("00",id[index],".csv",sep = "")
    }else if(id[index] < 100 && id[index]>=10){
      
      file_name <- paste("0",id[index],".csv",sep = "")
      
    }else{
      
      file_name <- paste(id[index],".csv",sep = "")
    }
    return(file_name)
  }#get.NamedFile
  old.dir <- getwd()
  setwd(directory)
  print(paste("change work directory to:"))
  print(getwd())
  
  counts <- rep(NA, times = length(id))
  for (idx in 1:length(id)) {
    file_name <- get.NamedFile(idx)
    df <- read.csv(file_name)
    nna <- complete.cases(df)
    counts[idx] <- sum(nna)
  }
  df = data.frame(id=id,nobs= counts)
  setwd(old.dir)
  return(df)
}

path = "Data/specdata"
#df <- corr(path)
