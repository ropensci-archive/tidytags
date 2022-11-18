#' Filter a Twitter dataset to only include statuses of a particular type
#'
#' Starting with a dataframe of Twitter data imported to R with
#'   `read_tags()` and additional metadata retrieved by
#'   `pull_tweet_data()`, `filter_by_tweet_type()` processes the
#'   statuses by calling `process_tweets()` and then removes any statuses
#'   that are not of the requested type (e.g., replies, retweets, and quote
#'   tweets). `filter_by_tweet_type()` is a useful function in itself, but it is
#'   also used in `create_edgelist()`.
#' @param df A dataframe returned by `pull_tweet_data()`
#' @param type The specific kind of statuses that will be kept in the dataset
#'   after filtering the rest. Choices for `type`include "reply",
#'   "retweet", "quote", and "original".
#' @return A dataframe of processed statuses and fewer rows that the input
#'   dataframe. Only the statuses of the specified type will remain.
#' @examples
#'
#' \donttest{
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tags_content <- read_tags(example_url)
#'
#' if (rtweet::auth_has_default()) {
#'   tweets_data <- lookup_many_tweets(tags_content)
#'   only_replies <- filter_by_tweet_type(tweets_data, "reply")
#'   only_retweets <- filter_by_tweet_type(tweets_data, "retweet")
#'   only_quote_tweets <- filter_by_tweet_type(tweets_data, "quote")
#'   only_originals <- filter_by_tweet_type(tweets_data, "original")
#' }
#' }
#'
#' @export
filter_by_tweet_type <-
  function(df, type) {
    if("tweet_type" %in% names(df)) {
      processed_df <- df
      } else {
        processed_df <- process_tweets(df)
      }
    index <- processed_df$tweet_type == type
    processed_df[index, ]
  }

#' Create an edgelist where senders and receivers are defined by different types
#'   of Twitter interactions
#'
#' Starting with a dataframe of Twitter data imported to R with
#'   `read_tags()` and additional metadata retrieved by
#'   `pull_tweet_data()`, `create_edgelist()` removes any statuses
#'   that are not of the requested type (e.g., replies, retweets, and quote
#'   tweets) by calling `filter_by_tweet_type()`. Finally, `create_edgelist()`
#'   pulls out senders and receivers of the specified type of statuses, and then
#'   adds a new column called `edge_type`.
#' @param df A dataframe returned by `pull_tweet_data()`
#' @param type The specific kind of statuses used to define the interactions
#'   around which the edgelist will be built. Choices include "reply",
#'   "retweet", or "quote". Defaults to "all".
#' @return A dataframe edgelist defined by interactions through the type of
#'   statuses specified. The dataframe has three columns: `sender`,
#'   `receiver`, and `edge_type`.
#' @examples
#'
#' \donttest{
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tags_content <- read_tags(example_url)
#'
#' if (rtweet::auth_has_default()) {
#'   tweets_data <- lookup_many_tweets(tags_content)
#'   full_edgelist <- create_edgelist(tweets_data)
#'   full_edgelist
#'
#'   reply_edgelist <- create_edgelist(tweets_data, type = "reply")
#'   retweet_edgelist <- create_edgelist(tweets_data, type = "retweet")
#'   quote_edgelist <- create_edgelist(tweets_data, type = "quote")
#' }
#' }
#'
#' @importFrom rlang .data
#' @export
create_edgelist <-
  function(df, type = "all") {
    if(type != "all") {
      filtered_df <- filter_by_tweet_type(df, type)
    } else {
      filtered_df <-
        dplyr::bind_rows(
          filter_by_tweet_type(df, "reply"),
          filter_by_tweet_type(df, "retweet"),
          filter_by_tweet_type(df, "quote")
        )
    }

    filtered_df <- dplyr::rename(filtered_df, sender = .data$screen_name)
    el_reply <- NULL
    el_retweet <- NULL
    el_quote <- NULL

    if(nrow(dplyr::filter(filtered_df, .data$tweet_type == "reply")) > 0) {
      filtered_df_reply <-
        dplyr::filter(filtered_df, .data$tweet_type == "reply")
      receiver <- filtered_df_reply$in_reply_to_screen_name
      el_reply <-
        dplyr::select(filtered_df_reply, .data$tweet_type, .data$sender)
      el_reply <-
        dplyr::bind_cols(el_reply, receiver = receiver)
    }

    if(nrow(dplyr::filter(filtered_df, .data$tweet_type == "retweet")) > 0) {
      filtered_df_retweet <-
        dplyr::filter(filtered_df, .data$tweet_type == "retweet")
      receiver <- character()
      for(i in 1:nrow(filtered_df_retweet)) {
        receiver[i] <-
          filtered_df_retweet$retweeted_status[[1]]$user$screen_name
      }
      el_retweet <-
        dplyr::select(filtered_df_retweet, .data$tweet_type, .data$sender)
      el_retweet <-
        dplyr::bind_cols(el_retweet, receiver = receiver)
    }

    if(nrow(dplyr::filter(filtered_df, .data$tweet_type == "quote")) > 0) {
      filtered_df_quote <-
        dplyr::filter(filtered_df, .data$tweet_type == "quote")
      receiver <- character()
      for(i in 1:nrow(filtered_df_quote)) {
        receiver[i] <-
          filtered_df_quote$quoted_status[[1]]$user$screen_name
      }
      el_quote <-
        dplyr::select(filtered_df_quote, .data$tweet_type, .data$sender)
      el_quote <-
        dplyr::bind_cols(el_quote, receiver = receiver)
    }

    if(type == "all") {
      el <- dplyr::bind_rows(el_reply, el_retweet, el_quote)
    } else {
      if(type == "reply") {
        el <- el_reply
      } else {
        if(type =="retweet") {
          el <- el_retweet
        } else {
          el <- el_quote
        }
      }
    }

    el
  }
