get_replies <- function(df) {
  processed_df <- process_tweets(df)
  replies <- dplyr::filter(processed_df, is_reply)
  replies <- dplyr::select(replies,
                           sender = screen_name,
                           receiver = reply_to_screen_name)
  replies <- dplyr::mutate(replies,
                           edge_type = "reply")
  replies
}


get_retweets <- function(df) {
  processed_df <- process_tweets(df)
  RTs <- dplyr::filter(processed_df, is_retweet)
  RTs <- dplyr::select(RTs,
                       sender = screen_name,
                       receiver = retweet_screen_name)
  RTs <- dplyr::mutate(RTs,
                       edge_type = "retweet")
  RTs
}


get_quotes <- function(df) {
  processed_df <- process_tweets(df)
  quotes <- dplyr::filter(processed_df, is_quote)
  quotes <- dplyr::select(quotes,
                          sender = screen_name,
                          receiver = quoted_screen_name)
  quotes <- dplyr::mutate(quotes,
                          edge_type = "quote-tweet")
  quotes
}


get_mentions <- function(df) {
  processed_df <- process_tweets(df)
  mentions <- dplyr::select(processed_df,
                            sender = screen_name,
                            receiver = mentions_screen_name)
  mentions <- tidyr::unnest(mentions, cols = receiver)
  mentions <- dplyr::filter(mentions, !is.na(receiver))
  mentions <- dplyr::mutate(mentions, edge_type = "mention")
  mentions
}


create_edgelist <- function(df) {
  processed_df <- process_tweets(df)

  if (!is.list(processed_df$mentions_screen_name)) {
    processed_df$mentions_screen_name <- str_split(processed_df$mentions_screen_name, " ")
  }

  reply_edges <- get_replies(processed_df)
  retweet_edges <- get_retweets(processed_df)
  quote_edges <- get_quotes(processed_df)
  mention_edges <- get_mentions(processed_df)

  full_edgelist <- dplyr::bind_rows(reply_edges,
                                    retweet_edges,
                                    quote_edges,
                                    mention_edges)
  full_edgelist
}
