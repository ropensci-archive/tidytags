#' Retrieve a TAGS archive of Twitter statuses and bring into R
#'
#' Keep in mind that `read_tags()` uses the **googlesheets4** package,
#'   and one requirement is that your TAGS tracker has been "published to the
#'   web." To do this, with the TAGS page open in a web browser, navigate to
#'   `File >> Share >> Publish to the web`. The `Link` field should be
#'   'Entire document' and the `Embed` field should be 'Web page.' If
#'   everything looks right, then click the `Publish` button. Next, click
#'   the `Share` button in the top right corner of the Google Sheets
#'   browser window, select `Get shareable link`, and set the permissions
#'   to 'Anyone with the link can view.'
#' @param tags_id A Google Sheet identifier (i.e., the alphanumeric string
#'    following "https://docs.google.com/spreadsheets/d/" in the TAGS tracker's
#'    URL.)
#' @return A tibble of the TAGS archive of Twitter statuses
#' @seealso Read more about `library(googlesheets4)`
#'   [here](https://github.com/tidyverse/googlesheets4).
#' @examples
#'
#' \donttest{
#' example_tags <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' read_tags(example_tags)
#' }
#'
#' @export
read_tags <-
  function(tags_id) {
    googlesheets4::gs4_deauth()
    tweet_sheet <- googlesheets4::range_read(tags_id, sheet = 2)
    tweet_sheet
  }

#' Get Twitter status ID numbers as character strings
#'
#' This function is useful because Google Sheets (and hence TAGS)
#'   typically round very large numbers into an exponential form. Thus,
#'   because status ID numbers are very large, they often get corrupted in this
#'   rounding process. The most reliable way to get full status ID numbers is by
#'   using this function, `get_char_tweet_ids()`, to pull the ID numbers
#'   from the URL linking to specific statuses.
#' @param x A dataframe containing the column name 'status_url'
#'   (i.e., the hyperlink to specific statuses), such as that returned by
#'   `read_tags()`, or a vector of status URLs, such as as those contained
#'   in the 'status_url' column of a dataframe returned by
#'   `tidytags::read_tags()`
#' @return A vector of Twitter status IDs as character strings
#'
#' @examples
#'
#' \donttest{
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tags_content <- read_tags(example_url)
#' get_char_tweet_ids(tags_content[1:10, ])
#' get_char_tweet_ids(tags_content$status_url[1:10])
#' get_char_tweet_ids(
#'   "https://twitter.com/tweet__example/status/1176592704647716864")
#' }
#'
#' @export
get_char_tweet_ids <-
  function(x) {
    ifelse(is.data.frame(x),
           new_ids <-
             gsub("https?\\://twitter.com\\/.+/status(es)?/", "", x$status_url),
           new_ids <-
             gsub("https?\\://twitter.com\\/.+/status(es)?/", "", x)
    )
    new_ids
  }

#' Retrieve the fullest extent of status metadata available from the Twitter API
#'
#' With a TAGS archive imported into R, `pull_tweet_data()` uses the
#'   **rtweet** package to query the Twitter API. Using rtweet requires Twitter
#'   API keys associated with an approved developer account. Fortunately, the
#'   rtweet vignette,
#'   [Authentication](https://docs.ropensci.org/rtweet/articles/auth.html),
#'   provides a thorough guide to obtaining Twitter API keys and authenticating
#'   access to the Twitter API. Following the directions for "Apps," you will
#'   run the `rtweet::rtweet_app()` function.
#' @param df A dataframe of containing the column name 'status_url'
#'   (i.e., the hyperlink to specific statuses), such as that returned by
#'   `read_tags()`
#' @param url_vector A vector of status URLs, such as as those contained in
#'   the 'status_url' column of a dataframe returned by
#'   `tidytags::read_tags()`
#' @param id_vector A vector of statuses (i.e., ID numbers, such as
#'   those contained in the 'id_str' column of a dataframe returned by
#'   `tidytags::read_tags()`
#' @param n The number of statuses to look up, by default the total number
#'   of tweet ID numbers available, but capped at 90,000 due to Twitter API
#'   limitations.
#' @return A dataframe of statuses and full metadata from the Twitter API
#' @details This function requires authentication; please see
#'   `vignette("setup", package = "tidytags")`
#' @seealso Read more about rtweet authentication setup at
#'   `vignette("auth", package = "rtweet")`
#' @examples
#'
#' \donttest{
#' ## Import data from a TAGS tracker:
#' example_tags_tracker <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tags_content <- read_tags(example_tags_tracker)
#'
#' if (rtweet::auth_has_default()) {
#'   ## Use any of three input parameters (TAGS dataframe, `status_url`
#'   ##   column, or `id_str` column)
#'   tweets_data_from_df <- pull_tweet_data(tags_content)
#'   tweets_data_from_url <-
#'     pull_tweet_data(url_vector = tags_content$status_url)
#'   tweets_data_from_ids <- pull_tweet_data(id_vector = tags_content$id_str)
#'
#'   ## Specifying the parameter `n` clarifies how many statuses to look up,
#'   ##   but the returned values may be less than `n` because some statuses
#'   ##   may have been deleted or made protected since the TAGS tracker
#'   ##   originally recorded them.
#'   tweets_data_10 <- pull_tweet_data(tags_content, n = 10)
#'
#'   ## Note that the following two examples will return the same thing:
#'   one_tweet_data <-
#'     pull_tweet_data(url_vector =
#'       "https://twitter.com/tweet__example/status/1176592704647716864")
#'   one_tweet_data <- pull_tweet_data(id_vector = "1176592704647716864")
#'   one_tweet_data
#' }
#' }
#'
#' @export
pull_tweet_data <-
  function(df = NULL, url_vector = NULL, id_vector = NULL, n = NULL) {
    ifelse(!is.null(url_vector),
      {
        if (is.null(n)) {
          n <- length(url_vector)
        }
        if (n > 90000) {
          warning(
            "Twitter API only allows lookup of 90,000 tweets at a time;",
            "collecting data for first 90,000 tweet IDs.",
            "To process more, use `lookup_many_tweets()`."
          )
          n <- 90000
        }

        new_df <- rtweet::lookup_tweets(get_char_tweet_ids(url_vector[1:n]))
      },
      ifelse(!is.null(id_vector),
        {
          if (is.null(n)) {
            n <- length(id_vector)
          }
          if (n > 90000) {
            warning(
              "Twitter API only allows lookup of 90,000 tweets at a time;",
              "collecting data for first 90,000 tweet IDs.",
              "To process more, use `lookup_many_tweets()`."
            )
            n <- 90000
          }

          new_df <- rtweet::lookup_tweets(id_vector[1:n])
        },
        {
          if (is.null(n)) {
            n <- nrow(df)
          }

          if (n > 90000) {
            warning(
              "Twitter API only allows lookup of 90,000 tweets at a time;",
              "collecting data for first 90,000 tweet IDs.",
              "To process more, use `lookup_many_tweets()`."
            )
            n <- 90000
          }

          new_df <- rtweet::lookup_tweets(get_char_tweet_ids(df[1:n, ]))
        }
      )
    )

    if(nrow(new_df) > 0) {
      user_info <- rtweet::users_data(new_df)
      duplicate_index <- which(colnames(user_info) %in% colnames(new_df))
      colnames(user_info)[duplicate_index] <-
        paste0("user_", colnames(user_info)[duplicate_index])
      new_df <- cbind(new_df, user_info)

      tweets_col_order <-
        c("created_at", "id", "id_str", "text", "full_text", "truncated",
          "entities", "source", "in_reply_to_status_id",
          "in_reply_to_status_id_str", "in_reply_to_user_id",
          "in_reply_to_user_id_str", "in_reply_to_screen_name", "geo",
          "coordinates", "place", "contributors", "is_quote_status",
          "retweet_count", "favorite_count", "favorited", "favorited_by",
          "retweeted", "scopes", "lang", "possibly_sensitive",
          "display_text_width", "display_text_range", "retweeted_status",
          "quoted_status", "quoted_status_id", "quoted_status_id_str",
          "quoted_status_permalink", "quote_count", "timestamp_ms",
          "reply_count","filter_level", "metadata", "query", "withheld_scope",
          "withheld_copyright", "withheld_in_countries",
          "possibly_sensitive_appealable", "user_id", "user_id_str", "name",
          "screen_name", "location", "description", "url", "protected",
          "followers_count", "friends_count", "listed_count", "user_created_at",
          "favourites_count", "verified", "statuses_count",
          "profile_image_url_https", "profile_banner_url", "default_profile",
          "default_profile_image", "user_withheld_in_countries", "derived",
          "user_withheld_scope", "user_entities")
      new_df <- new_df[, tweets_col_order]

    } else {
      message("pull_tweet_data() was unable to retrieve any additional data")
      new_df <- NULL
    }

    new_df
  }

#' Retrieve the fullest extent of metadata for more than 90,000 statuses
#'
#' This function calls `pull_tweet_data()`, but has a built-in delay
#'   of 15 minutes to allow the Twitter API to reset after looking up 90,000
#'   statuses
#' @param x A list or vector of status ID numbers
#' @param alarm An audible notification that a batch of 90,000 statuses has been
#'   completed
#' @return A dataframe of statuses and full metadata from the Twitter API
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
#'   tweets_data <- lookup_many_tweets(tags_content$id_str)
#'   one_tweet_data <- lookup_many_tweets("1176592704647716864")
#'   one_tweet_data <- lookup_many_tweets("1176592704647716864", alarm = TRUE)
#'   one_tweet_data
#' }
#' }
#'
#' @export
lookup_many_tweets <-
  function(x, alarm = FALSE) {
    n_batches <- ceiling(length(x) / 90000)
    new_df <- data.frame()
    for (i in 1:n_batches) {
      min_id <- 90000 * i - 89999
      max_id <- ifelse(90000 * i < length(x), 90000 * i, length(x))
      tmp_df <- pull_tweet_data(id_vector = x[min_id:max_id])
      new_df <- rbind(new_df, tmp_df)
      if (alarm == TRUE) {
        if (!requireNamespace("beepr", quietly = TRUE)) {
          stop(
            "Please install the {beepr} package to use this function",
            call. = FALSE
          )
        }
        beepr::beep(2)
      }
      if (n_batches > 1) {
        message("I've finished processing batch: ", i, " of ", n_batches)
      }
      if (i != n_batches) {
        message("Hold on, I need to nap for about 15 minutes...")
        Sys.sleep(901)
        message("I'm awake and back to work!")
      }
    }
    new_df
  }

#' Count the number of mentions in a status
#'
#' @param df A dataframe of statuses and full metadata from the Twitter API as
#'   returned by `pull_tweet_data()`
#' @return A vector of the number of mentions in each status in the dataframe
#' @keywords internal
#' @noRd
get_mentions_count <-
  function(df) {
    mentions_count <- integer()
    for(i in 1:nrow(df)) {
      mentions_list <- df$entities[[i]]$user_mentions$screen_name
      mentions_count[i] <-
        ifelse(is.na(mentions_list[1]),
               0,
               length(mentions_list)
        )
    }
    mentions_count
  }

#' Count the number of hashtags in a status
#'
#' @param df A dataframe of statuses and full metadata from the Twitter API as
#'   returned by `pull_tweet_data()`
#' @return A vector of the number of hashtags in each status in the dataframe
#' @keywords internal
#' @noRd
get_hashtags_count <-
  function(df) {
    hashtags_count_vector <- integer()
    for(i in 1:nrow(df)) {
      hashtags_list <- df$entities[[i]]$hashtags$text
      hashtags_n <-
        ifelse(is.na(hashtags_list[1]),
               0,
               as.numeric(length(hashtags_list))
        )
      hashtags_count_vector[i] <- hashtags_n
    }
    hashtags_count_vector
  }

#' Count the number of URLs in a status
#'
#' @param df A dataframe of statuses and full metadata from the Twitter API as
#'   returned by `pull_tweet_data()`
#' @return A vector of the number of URLs in each status in the dataframe
#' @keywords internal
#' @noRd
get_urls_count <-
  function(df) {
    urls_count <- integer()
    for(i in 1:nrow(df)) {
      urls_list <- df$entities[[i]]$urls$expanded_url
      urls_n <-
        ifelse(is.na(urls_list[1]),
               0,
               as.numeric(length(urls_list))
        )
      urls_count <- c(urls_count, urls_n)
    }
    urls_count
  }

#' Determine the tweet type for each status
#'
#' @param df A dataframe of statuses and full metadata from the Twitter API as
#'   returned by `pull_tweet_data()`
#' @return A vector of tweet types of each status in the dataframe
#' @keywords internal
#' @noRd
get_tweet_type <-
  function(df) {
    mentions_vector <- get_mentions_count(df)
    tweet_type <- character()
    for(i in 1:nrow(df)) {
      tweet_type[i] <-
        ifelse(grepl("^RT", df$full_text[i]),
               "retweet",
               ifelse(!is.na(df$quoted_status_id_str[i]),
                      "quote",
                      ifelse(!is.na(df$in_reply_to_status_id_str[i]),
                             "reply",
                             ifelse(mentions_vector[i] > 0,
                                    "mention",
                                    "original"
                             )
                      )
               )
        )
    }
    tweet_type
  }

#' Calculate additional information using status metadata
#'
#' @param df A dataframe of statuses and full metadata from the Twitter API as
#'   returned by `pull_tweet_data()`
#' @return A dataframe with several additional columns: mentions_count,
#'   hashtags_count, urls_count, tweet_type, is_self_reply
#' @examples
#'
#' \donttest{
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tags_content <- read_tags(example_url)
#'
#' if (rtweet::auth_has_default()) {
#'   tweets_data <- lookup_many_tweets(tags_content)
#'   tweets_processed <- process_tweets(tweets_data)
#'   tweets_processed
#' }
#' }
#'
#' @importFrom rlang .data
#' @export
process_tweets <-
  function(df) {
    df$mentions_count <- get_mentions_count(df)
    df$hashtags_count <-  get_hashtags_count(df)
    df$urls_count <- get_urls_count(df)
    df$tweet_type <- get_tweet_type(df)
    df <-
      dplyr::mutate(df,
        is_self_reply =
          ifelse(
            .data$tweet_type == "reply" &
              .data$user_id_str == .data$in_reply_to_user_id_str,
            TRUE,
            FALSE
          )
      )
    df
  }
