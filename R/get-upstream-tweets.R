#' Flag any upstream statuses not already in a dataset
#'
#' Because the Twitter API offers a `in_reply_to_status_id_str` column, it is
#'   possible to iteratively reconstruct reply threads in an *upstream*
#'   direction, that is, retrieving statuses composed earlier than replies in
#'   the dataset. The `flag_unknown_upstream()` function identifies which
#'   statuses are replies to statuses not found in the current dataset.
#' @param df A dataframe of statuses and full metadata from the Twitter API as
#'   returned by `pull_tweet_data()`
#' @return A new, filtered dataframe which only includes any reply statuses that
#'   are not responses to statuses already in the dataset (i.e., upstream
#'   replies)
#' @importFrom rlang .data
#' @keywords internal
#' @noRd
flag_unknown_upstream <-
  function(df) {
    unknown_upstream <-
      dplyr::filter(df,
                    !is.na(.data$in_reply_to_status_id_str) &
                      !(.data$in_reply_to_status_id_str %in%
                          df$id_str)
      )
    unknown_upstream
  }

#' Collect upstream statuses and add to dataset
#'
#' Because the Twitter API offers a `in_reply_to_status_id_str` column, it is
#'   possible to iteratively reconstruct reply threads in an *upstream*
#'   direction, that is, retrieving statuses composed earlier than replies in
#'   the dataset. The `get_upstream_tweets()` function collects upstream
#'   replies not previously found in the dataset. Keep in mind that there is no
#'   way to predict how far upstream you can trace back a reply thread, so
#'   running `get_upstream_tweets()` could take a while and potentially hit
#'   the Twitter API rate limit of 90,000 statuses in a 15-minute period.
#' @param df A dataframe of statuses and full metadata from the Twitter API as
#'   returned by `pull_tweet_data()`
#' @return A new, expanded dataframe which includes any retrievable upstream
#'   replies
#' @details This function requires authentication; please see
#'   `vignette("setup", package = "tidytags")`
#' @seealso Read more about rtweet authentication setup at
#'   `vignette("auth", package = "rtweet")`
#' @examples
#'
#' \donttest{
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tags_content <- read_tags(example_url)
#'
#' if (rtweet::auth_has_default()) {
#'   tweets_data <- lookup_many_tweets(tags_content)
#'   more_replies_df <- get_upstream_tweets(tweets_data)
#'   more_replies_df
#' }
#' }
#'
#' @export
get_upstream_tweets <-
  function(df) {
    unknown_upstream <- flag_unknown_upstream(df)

    if (nrow(unknown_upstream) == 0) {
      message("There are no upstream replies to get.")
    } else {

      searchable_replies <-
        pull_tweet_data(id_vector = unknown_upstream$in_reply_to_status_id_str)
      searchable_n <-
        ifelse(is.null(searchable_replies), 0, nrow(searchable_replies))

      if (searchable_n > 0) {
        i <- 0
        n <- 0
        while (searchable_n > 0) {
          i <- i + 1
          message("Iteration: ", i)
          new_tweets <-
            pull_tweet_data(id_vector =
                              unknown_upstream$in_reply_to_status_id_str)
          n <- n + nrow(new_tweets)
          df <- rbind(df, new_tweets)

          unknown_upstream <- flag_unknown_upstream(df)

          searchable_replies <-
            pull_tweet_data(id_vector =
                              unknown_upstream$in_reply_to_status_id_str)
          searchable_n <-
            ifelse(is.null(searchable_replies), 0, nrow(searchable_replies))

          message(
            "New statuses added to the dataset: ",
            nrow(new_tweets),
            "; reply statuses that were not able to be retrieved: ",
            nrow(unknown_upstream),
            "; newly added replies where we can still go further upstream: ",
            nrow(searchable_replies)
          )
        }

        message("We've gone as far upstream as we're able to go.",
                " This process resulted in ", n,
                " new replies being added to the dataset.")
      }
    }
    df
  }
