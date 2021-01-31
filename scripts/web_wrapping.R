## Setting connection
con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
## Parsing html to text
htmlcode = readLines(con)
close(con)

## USING XML library
library(XML)
url.path <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
file <- "file.html"
download.file(url.path, file, method = "curl")
html <- htmlTreeParse(file = file, useInternalNodes = T)
xpathSApply(html,"//title", xmlValue)
xpathSApply(html,"//td[@id='col-citedby']", xmlValue)


## USING httr 
library(httr)
## getting page
html2 <- GET(url.path)
## extract content
content <- content(html2, as = "text")
## parsing content
parsedhtml <- htmlParse(content, asText = T)
xpathSApply(parsedhtml,"//title", xmlValue)

## Pages with password
url.dir <- ""
page <- GET(url.dir, authenticate("user", password = "") )


## Connecting api with keys
## creating the app auth
myapp <- oauth_app("twitter", 
                   key = "", secret = "")
sig = sign_oauth1.0(myapp, token = "",
                    token_secret = "" )
homeTL =GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
