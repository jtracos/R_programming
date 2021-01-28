
pollutantmean <- function(directory, pollutant, id =1:332){
  
  get.NamedFile <- function(index){
    ##this function names the file for the id
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
  
  data <-c()
  for( idx in 1:length(id)){
    
    file_name <- get.NamedFile(index = idx)
    if (file.exists(file_name)){
      #leyendo los datos 
      df <- read.csv(file_name)
      # obtener media
      selected <- !is.na(df[[pollutant]])
      df <- df[selected,]
      data <- c(data, df[[pollutant]])
      
    } else{
      print(paste("file ",file_name, " no existe",sep = ""))
      break
    }#else

  }#for
  #reset the work directory
  setwd(old.dir)
  mvalue <- mean(data)
  return(mvalue)
}

main <- function(){
  sulf <- pollutantmean(directory = path, pollutant = "sulfate", id =1:10)
  nitr <- pollutantmean(directory = path, pollutant = "nitrate", id =70:72)
  print("La media de los sulfatos es:")
  print(sulf)
  print("La media de los nitratos es:")
  print(nitr)
}
main()