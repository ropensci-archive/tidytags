#' Flag any upstream tweets not already in a dataset
#'
#' Because the Twitter API offers a \code{reply_to_status_id} column, it is
#'   possible to iteratively reconstruct reply threads in an *upstream*
#'   direction, that is, retrieving tweets composed earlier than replies in the
#'   dataset. The \code{flag_unknown_upstream()} function identifies which
#'   tweets are replies to tweets not found in the current dataset.
#' @param df A dataframe of tweets and full metadata from the Twitter API as
#'   returned by \code{pull_tweet_data()}
#' @return A new, filtered dataframe which only includes any reply tweets that
#'   are not responses to tweets already in the dataset (i.e., upstream replies)
#' @keywords internal
#' @noRd
flag_unknown_upstream <-
  function(df) {
    unknown_upstream <-
      dplyr::filter(df,
                    !is.na(.data$reply_to_status_id) &
                      !(.data$reply_to_status_id %in% df$status_id)
      )
    unknown_upstream
  }

#' Collect upstream tweets and add to dataset
#'
#' Because the Twitter API offers a \code{reply_to_status_id} column, it is
#'   possible to iteratively reconstruct reply threads in an *upstream*
#'   direction, that is, retrieving tweets composed earlier than replies in the
#'   dataset. The \code{get_upstream_tweets()} function collects upstream
#'   replies not previously found in the dataset. Keep in mind that there is no
#'   way to predict how far upstream you can trace back a reply thread, so
#'   running \code{get_upstream_tweets()} could take a while and potentially hit
#'   the Twitter API rate limit of 90,000 tweets in a 15-minute period.
#' @param df A dataframe of tweets and full metadata from the Twitter API as
#'   returned by \code{pull_tweet_data()}
#' @return A new, expanded dataframe which includes any retrievable upstream
#'   replies
#' @details This function requires authentication; please see
#'   \code{vignette("setup", package = "tidytags")}
#' @examples
#'
#' \dontrun{
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url))
#' more_replies_df <- get_upstream_tweets(tmp_df)
#' more_replies_df
#' }
#' @importFrom rlang .data
#' @export
get_upstream_tweets <-
  function(df) {
    unknown_upstream <- flag_unknown_upstream(df)

    if (nrow(unknown_upstream) == 0)
      message("There are no upstream replies to get.")

    searchable_replies <-
      nrow(pull_tweet_data(id_vector =
                             unknown_upstream$reply_to_status_id))

    if (searchable_replies > 0) {
      i <- 0
      n <- 0
      while (searchable_replies > 0) {
        i <- i + 1
        message("Iteration: ", i)
        new_tweets <-
          pull_tweet_data(id_vector = unknown_upstream$reply_to_status_id)
        n <- n + nrow(new_tweets)
        df <- rbind(df, new_tweets)

        unknown_upstream <- flag_unknown_upstream(df)

        searchable_replies <-
          nrow(pull_tweet_data(id_vector =
                                 unknown_upstream$reply_to_status_id))

        message(
          "New tweets added to the dataset: ", nrow(new_tweets),
          "; reply tweets that were not able to be retrieved: ", nrow(unknown_upstream),
          "; newly added replies where we can still go further upstream: ", searchable_replies
        )
      }

      message("We've gone as far upstream as we're able to go.",
              " This process resulted in ", n,
              " new replies being added to the dataset.")
    }

    df
  }
