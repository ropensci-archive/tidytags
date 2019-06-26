# library(dplyr)
# library(googlesheets)

## https://github.com/jennybc/googlesheets

#b_url <- "https://docs.google.com/spreadsheets/d/1s5Zyd0u_Y0GLooNgQDUanXZDACZxdnc4fHc5wgZ6JE0/edit#gid=8743918"
j_url <- "https://docs.google.com/spreadsheets/d/1WM2xWG9B0Wqn3YG5uakfy_NSAEzIFP2nEAJ5U_fqufc/edit#gid=8743918"

read_tags <- function(url) {
  u <- googlesheets::gs_url(url)
  d <- googlesheets::gs_read(u, ws = 2)
  d
}

# "https://docs.google.com/spreadsheets/d/1WM2xWG9B0Wqn3YG5uakfy_NSAEzIFP2nEAJ5U_fqufc/edit#gid=8743918" %>%
#   read_tags() %>%
#   pull_data(n = 1000) %>%
#   create_edgelist()

pull_data <- function(df, n = NULL) {
  if(is.null(n)) n <- nrow(df)
  split_status <- stringr::str_split(df$status_url, "/")
  status_id <- purrr::map(split_status, ~ .[[6]])
  status_id <- unlist(status_id)
  d <- rtweet::lookup_statuses(status_id[1:n])
  d
}

length_with_na <- function(x) {
  ifelse(is.na(x), 0, map_int(x, length))
}

proc_tweets <- function(d) {
  d %>%
    mutate(mentions_count = length_with_na(mentions_screen_name),
           hashtags_count = length_with_na(hashtags),
           urls_count = length_with_na(urls_url),
           is_reply = if_else(!is.na(reply_to_status_id), TRUE, FALSE))
}

proc_tweets_flattened <- function(d) {
  d %>%
    mutate(mentions_count = length_with_na(str_split(mentions_screen_name, " ")),
           hashtags_count = length_with_na(str_split(hashtags, " ")),
           urls_count = length_with_na(str_split(urls_url, " ")),
           is_reply = if_else(!is.na(reply_to_status_id), TRUE, FALSE))
}

#proc_tweets(d) %>% select(urls_url, urls_count) %>% View()
