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

proc_tweets <- function(d) {
  d %>%
    mutate(mentions_count = map_int(mentions_screen_name, length),
           hashtags_count = map_int(str_split(as.character(hashtags), " "), length),
           urls_count = map_int(str_split(as.character(urls_url), " "), length),
           is_reply = if_else(!is.na(reply_to_status_id), TRUE, FALSE))
}

# Replies

get_replies <- function(d) {
  reply_tweets <- d %>%
    filter(is_reply == 1) %>%
    count(screen_name, status_id, reply_to_status_id) %>%
    select(sender = screen_name, replies_count = n, reply_status_id = status_id, status_id = reply_to_status_id)

  replied_to_tweets <- lookup_statuses(reply_tweets$status_id)
  replied_to_tweets <- proc_tweets(replied_to_tweets)

  replied_to_tweets %>%
    left_join(reply_tweets, by = c("status_id")) %>%
    select(sender, receiver = screen_name) %>%
    mutate(edge_type = "reply")
}

# Retweets

get_retweets <- function(d) {
  d %>%
    filter(is_retweet) %>%
    select(sender = screen_name, receiver = retweet_screen_name) %>%
    mutate(edge_type = "retweet")
}


# Favorites

# dd %>%
#   select(status_id, screen_name)
#
ex_favs <- get_favorites(user = d[1, ]$screen_name,
              max_id = d[1, ]$status_id)

ex_favs$status_id %in% d[1, ]$status_id
View(ex_favs)
#
# list(status_id = dd$status_id, screen_name = dd$screen_name) %>%
#   map2(.f = get_favorites())

# Quotes

get_quotes <- function(d) {
  d %>%
    filter(is_quote) %>%
    select(sender = screen_name, receiver  =quoted_screen_name) %>%
    mutate(edge_type = "quotes")
}


# Mentions

get_mentions <- function(d) {
  d %>%
    select(screen_name, mentions_screen_name) %>%
    unnest() %>%
    rename(sender = screen_name, receiver = mentions_screen_name) %>%
    mutate(edge_type = "mention")
}

# Create edgelist

create_edgelist <- function(d) {

  dd <- proc_tweets(d)

  # these can be processed from the data
  retweet_edges <- get_retweets(dd)
  quote_edges <- get_quotes(dd)
  mention_edges <- get_mentions(dd)

  # these require additional API calls
  reply_edges <- get_replies(dd)
  # favorite_edges <- get_favorites(dd)

  bind_rows(retweet_edges,
            quote_edges,
            mention_edges,
            reply_edges)
}

# Example

# install.packages("gender")
