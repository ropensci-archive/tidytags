#' Collect upstream replies and add to dataset
#'
#' @param df A dataframe or tibble
#' @return A new dataframe which includes any retrievable upstream replies
get_upstream_replies <- function(df) {
  processed_df <- process_tweets(df)
  unknown_replies <- dplyr::filter(processed_df,
                                   is_reply & !(reply_to_status_id %in% processed_df$status_id)
                                   )
  searchable_replies <- nrow(pull_tweet_data(unknown_replies$reply_to_status_id))
  i <- 0

  while(searchable_replies > 0) {
    i = i + 1
    print(paste("Iteration:", i))
    new_tweets <- process_tweets(pull_tweet_data(unknown_replies$reply_to_status_id))
    processed_df <- rbind(processed_df, new_tweets)
    unknown_replies <- dplyr::filter(processed_df,
                                     is_reply & !(reply_to_status_id %in% processed_df$status_id)
                                     )
    searchable_replies <- nrow(pull_tweet_data(unknown_replies$reply_to_status_id))
    print(paste0("New tweets added: ", nrow(new_tweets),
                 "; Unknown replies:", nrow(unknown_replies),
                 "; Searchable replies: ", searchable_replies))
  }

  processed_df
}
