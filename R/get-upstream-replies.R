#' Collect upstream replies and add to dataset
#'
#' \code{get_upstream_replies()} collects upstream replies not previously found
#'   in the dataset.
#' @param df A dataframe of tweets and full metadata from the Twitter API as returned
#'   by \code{pull_tweet_data()}
#' @return A new, expanded dataframe which includes any retrievable upstream replies
#' @examples
#'
#' \dontrun{
#' example_url <- "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/edit#gid=8743918"
#' tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#' new_df <- get_upstream_replies(tmp_df)
#' new_df
#' }
#' @importFrom rlang .data
#' @export
get_upstream_replies <-
  function(df) {
    processed_df <- process_tweets(df)
    unknown_replies <-
      dplyr::filter(
        processed_df,
        .data$is_reply &
          !(.data$reply_to_status_id %in% processed_df$status_id)
      )
    searchable_replies <- 0
    if (nrow(unknown_replies) == 0) message("There are no upstream replies to add.")
    searchable_replies <- nrow(pull_tweet_data(id_vector = unknown_replies$reply_to_status_id))
    if (searchable_replies > 0) {
      i <- 0
      n <- 0
      while (searchable_replies > 0) {
        i <- i + 1
        message("Iteration: ", i)
        new_tweets <- process_tweets(pull_tweet_data(id_vector = unknown_replies$reply_to_status_id))
        n <- n + nrow(new_tweets)
        processed_df <- rbind(processed_df, new_tweets)
        unknown_replies <- dplyr::filter(
          processed_df,
          .data$is_reply &
            !(.data$reply_to_status_id %in% processed_df$status_id)
        )
        searchable_replies <- nrow(pull_tweet_data(id_vector = unknown_replies$reply_to_status_id))
        message(
          "New tweets added: ", nrow(new_tweets),
          "; Unknown replies: ", nrow(unknown_replies),
          "; Searchable replies: ", searchable_replies
        )
      }
      message("End of retrieval; ", n, " new replies added.")
    }
    processed_df
  }
