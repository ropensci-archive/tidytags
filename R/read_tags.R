library(dplyr)

library(googlesheets)
## https://github.com/jennybc/googlesheets

url <- "https://docs.google.com/spreadsheets/d/1s5Zyd0u_Y0GLooNgQDUanXZDACZxdnc4fHc5wgZ6JE0/edit#gid=8743918"
file <- "siteconf.csv"

df <- gs_url(url) %>%
        gs_download(ws=2, to=file, overwrite=TRUE) %>%
        file %>% read.csv(header=TRUE, colClasses='character')
dim(df)


## --------------------------------------------------------------
## pull full tweet content using library(rtweet)
## --------------------------------------------------------------

## See https://rtweet.info/ for details on library(rtweet)
## See https://rtweet.info/reference/index.html for all rtweet functions
## See https://apps.twitter.com/ for details on Twitter developer application

#tokens <- read.csv(file="~/private_data/bretsw_twitter_research_app.csv",
#                   header=TRUE, sep=",", colClasses='character')

#create_token(
#        app = "bretsw_twitter_research_app",
#        consumer_key = tokens$consumer_key,
#        consumer_secret = tokens$consumer_secret,
#        access_token = tokens$access_token,
#        access_secret = tokens$access_secret)

#statuses <- ntchat_all[[1]] %>% as.data.frame %>% pull(id_str)

#ntchat_rtweet <- statuses %>% lookup_tweets %>% flatten  # Returns data on up to 90,000 Twitter statuses.
#ntchat_rtweet %>% dim
#ntchat_rtweet %>% write.csv("ntchat_rtweet.csv", row.names=FALSE)

