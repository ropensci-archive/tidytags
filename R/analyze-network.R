#' Create an edgelist where interaction is defined by replying
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{get_replies()} pulls out senders and receivers of reply tweets and
#'   adds a new column \code{edge_type}. \code{get_replies()} is a useful function
#'   in itself, but is also used in \code{create_edgelist()}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @return A dataframe edgelist with column names 'sender', 'receiver', and
#'   \code{edge_type}, which in this case the edge type is "reply"
#' @seealso Compare to other \code{tidtags} functions such as \code{get_retweets()},
#'   \code{get_quotes()}, \code{get_mentions()}, and \code{create_edgelist()}.
#' @export
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

#' Create an edgelist where interaction is defined by retweeting
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{get_retweets()} pulls out senders and receivers of retweets and adds
#'   a new column \code{edge_type}. \code{get_retweets()} is a useful function
#'   in itself, but is also used in \code{create_edgelist()}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @return A dataframe edgelist with column names 'sender', 'receiver', and
#'   \code{edge_type}, which in this case the edge type is "retweet"
#' @seealso Compare to other \code{tidtags} functions such as \code{get_replies()},
#'   \code{get_quotes()}, \code{get_mentions()}, and \code{create_edgelist()}.
#' @export
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

#' Create an edgelist where interaction is defined by quote-tweeting
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{get_quotes()} pulls out senders and receivers of quote tweets and adds
#'   a new column \code{edge_type}. \code{get_quotes()} is a useful function
#'   in itself, but is also used in \code{create_edgelist()}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @return A dataframe edgelist with column names 'sender', 'receiver', and
#'   \code{edge_type}, which in this case the edge type is "quote-tweet"
#' @seealso Compare to other \code{tidtags} functions such as \code{get_replies()},
#'   \code{get_retweets()}, \code{get_mentions()}, and \code{create_edgelist()}.
#' @export
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

#' Create an edgelist where interaction is defined by mentioning
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{get_mentions()} pulls out senders and receivers of mentions and adds
#'   a new column \code{edge_type}. \code{get_mentions()} is a useful function
#'   in itself, but is also used in \code{create_edgelist()}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @return A dataframe edgelist with column names 'sender', 'receiver', and
#'   \code{edge_type}, which in this case the edge type is "mention"
#' @seealso Compare to other \code{tidtags} functions such as \code{get_replies()},
#'   \code{get_retweets()}, \code{get_quotes()}, and \code{create_edgelist()}.
#' @export
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

#' Create an edgelist with several types of interaction
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{create_edgelist()} pulls out senders and receivers of reply tweets,
#'   retweets, quote tweets, and mentions, and then adds a new column
#'   \code{edge_type}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @return A dataframe edgelist with column names 'sender', 'receiver', and
#'   \code{edge_type}, which in this case the edge type may be "reply", "retweet",
#'   "quote", or "mention"
#' @seealso Compare to other \code{tidtags} functions such as \code{get_replies()},
#'   \code{get_retweets()}, \code{get_quotes()}, and \code{get_mentions()}.
#' @export
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
