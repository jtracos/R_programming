## Load data from mysql
library(DBI)
library(RMySQL)

##Make connection
uscscDb <- dbConnect(MySQL(), user = "genome",host="genome-mysql.cse.ucsc.edu")
## Getting query
results <- dbGetQuery(uscscDb, "show databases;");dbDisconnect(uscscDb)


##Make connection to database
hg19 <- dbConnect(MySQL(), user = "genome",db ="hg19",
                     host="genome-mysql.cse.ucsc.edu")
## list all tables on database
allTables <- dbListTables(hg19)
length(allTables)

##List fields of database
dbListFields(hg19,"affyU133Plus2")
##count items on a table
hg19 <-dbGetQuery(hg19,"select count(*) from affyU133Plus2")

## Reading the table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

## selecting a subset from tables
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
## reading the query results
fetch(query, n=10)
## disconnect the query
dbClearResult(query)
## disconnect the database
dbDisconnect(hg19)