
# Replies

get_replies <- function(d) {
  reply_tweets <- d %>%
    filter(is_reply == 1) %>%
    count(screen_name, status_id, reply_to_status_id) %>%
    select(sender = screen_name, replies_count = n, reply_status_id = status_id, status_id = reply_to_status_id) %>%
    mutate(status_id = as.character(status_id))

  message("Getting ", nrow(reply_tweets), " additional replies; may take a few moments.")

  replied_to_tweets <- lookup_statuses(reply_tweets$status_id)
  replied_to_tweets <- proc_tweets(replied_to_tweets)

  replied_to_tweets %>%
    mutate(status_id = as.character(status_id)) %>%
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
# ex_favs <- get_favorites(user = d[1, ]$screen_name,
#               max_id = d[1, ]$status_id)
#
# ex_favs$status_id %in% d[1, ]$status_id
# View(ex_favs)
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
    filter(!is.na(receiver)) %>%
    mutate(edge_type = "mention")
}

# Create edgelist

create_edgelist <- function(d) {

  dd <- proc_tweets(d)

  if (!is.list(dd$mentions_screen_name)) {
    dd$mentions_screen_name <- str_split(dd$mentions_screen_name, " ")
  }

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
