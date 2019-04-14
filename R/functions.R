# library(dplyr)
# library(googlesheets)

## https://github.com/jennybc/googlesheets

#b_url <- "https://docs.google.com/spreadsheets/d/1s5Zyd0u_Y0GLooNgQDUanXZDACZxdnc4fHc5wgZ6JE0/edit#gid=8743918"
# j_url <- "https://docs.google.com/spreadsheets/d/1WM2xWG9B0Wqn3YG5uakfy_NSAEzIFP2nEAJ5U_fqufc/edit#gid=8743918"

read_tags <- function(url) {
    u <- googlesheets::gs_url(url)
    d <- googlesheets::gs_read(u, ws = 2)
    d
}


pull_data <- function(df, n = NULL) {
    if(is.null(n)) n <- nrow(df)
    split_status <- stringr::str_split(df$status_url, "/")
    status_id <- purrr::map(split_status, ~ .[[6]])
    status_id <- unlist(status_id)
    d <- rtweet::lookup_statuses(status_id[1:n])
    d
}

create_edgelist <- function() {

}

reply_tweets <- df_ss %>%
        filter(type=="REPLY") %>%
        count(reply_to_status_id) %>%
        rename(replies_count = n)

d <- d %>%
        mutate(mentions_count = sapply(mentions_screen_name, length),
               hashtags_count = sapply(str_split(hashtags, " "), length),
               urls_count = sapply(str_split(urls_url, " "), length),
               is_reply = if_else(!is.na(reply_to_status_id), 1, 0))

prepped_data <- df_ss %>%
        filter(type=="ORIG") %>%
        mutate(reply_to_status_id = status_id) %>%
        left_join(reply_tweets, by = "reply_to_status_id") %>%
        mutate(replies_count = ifelse(is.na(replies_count), 0, replies_count)) %>%

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
