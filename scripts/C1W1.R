## getting data on csv format
url.path <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
path.file <- "Data/usa_communities.csv"
download.file(url = url.path, destfile = paste(getwd(),path.file, sep="/"), 
              method = "curl")
library(data.table)
## convert to data.table and extract information
table.data <- data.table(read.csv(path.file))
sum(table.data$VAL[!is.na(table.data$VAL)]>23)

## Download xlsx data from internet
url.path2 <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
path.file2 <- "Data/ngap.xlsx"
download.file(url = url.path2, destfile = paste(getwd(),path.file2, sep="/"),
              method = "curl")
library(xlsx)
## Reading data
table.data <- read.xlsx(path.file2, sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)

## Downloading xml data from internet
url.path3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
path.file3 <- "Data/restaurants.xml"
download.file(url = url.path3, destfile = paste(getwd(),path.file3, sep="/"),               method = "curl")
library(xml)
## reading the xml
main <- htmlTreeParse(path.file3, useInternalNodes = T)
##getting root part
root <- xmlRoot(main)
## view attr names
xmlName(root)
## getting all zipvalues
zip.code <-xpathSApply(root,"//zipcode", xmlValue)

## Last download
url.path4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
path.file4 <- "Data/states_comm.csv"
download.file(url = url.path4, destfile = paste(getwd(),path.file4, sep="/"), 
              method = "curl")
library(data.table)
## loading data to table
states <- fread(path.file4)
