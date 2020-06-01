#' Retrieve a TAGS archive of tweets and bring into R
#'
#' Keep in mind that \code{read_tags()} uses the **googlesheets4** package,
#'   and one requirement is that your TAGS tracker has been "published to the web."
#'   To do this, with the TAGS page open in a web browser, navigate to
#'   \code{File >> Publish to the web}. The \code{Link} field should be 'Entire document'
#'   and the \code{Embed} field should be 'Web page.' If everything looks right,
#'   then click the \code{Publish} button. Next, click the \code{Share} button in the
#'   top right corner of the Google Sheets browser window, select \code{Get shareable link},
#'   and set the permissions to 'Anyone with the link can view.' The URL needed for R
#'   is simply the URL at the top of the web browser, just copy and paste at this point.
#'   Be sure to put quotations marks around the URL when entering it into \code{read_tags()}.
#' @param url A valid URL (i.e., hyperlink) to a TAGS tracker
#' @return A dataframe of the TAGS archive of tweets
#' @seealso Read more about \code{library(googlesheets4)} \href{https://github.com/tidyverse/googlesheets4}{here}.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/"
#' read_tags(example_url)
#'
#' }
#' @export
read_tags <-
  function(url) {
    tweet_sheet <- googlesheets4::read_sheet(url, sheet = 2)
    tweet_sheet
  }

#' Get tweet ID numbers as character strings
#'
#' This function is useful because Google Sheets (and hence TAGS)
#'   typically round very large numbers into an exponential form. Thus,
#'   because tweet ID numbers are very large, they often get corrupted in this
#'   rounding process. The most reliable way to get full tweet ID numbers is by
#'   using this function, \code{get_char_tweet_ids()}, to pull the ID numbers from
#'   the URL linking to specific tweets.
#' @param df A dataframe of containing the column name 'status_url'
#'   (i.e., the hyperlink to specific tweets), such as that returned by
#'   \code{read_tags()}
#' @param url_vector A vector of tweet URLs, such as as those contained in
#'   the 'status_url' column of a dataframe returned by \code{tidytags::read_tags()}
#' @return A list or vector of tweet IDs as character strings
#'
#' @examples
#'
#' \dontrun{
#' example_url <- "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/"
#' get_char_tweet_ids(read_tags(example_url)[1:10, ])
#' get_char_tweet_ids(url_vector = read_tags(example_url)$status_url[1:10])
#' get_char_tweet_ids(url_vector = "https://twitter.com/tweet__example/status/1176592704647716864")
#'
#' }
#' @importFrom rlang .data
get_char_tweet_ids <-
  function(df, url_vector = NULL) {
    ifelse(!is.null(url_vector),
           new_ids <- stringr::str_split_fixed(url_vector, "/", n = 6)[, 6],
           {
             df <- dplyr::mutate(df,
                                 status_id_char = stringr::str_split_fixed(.data$status_url,
                                                                           "/",
                                                                           n = 6
                                 )[, 6]
             )
             new_ids <- dplyr::pull(df, .data$status_id_char)
           }
    )
    new_ids
  }

#' Retrieve the fullest extent of tweet metadata available from the Twitter API
#'
#' With a TAGS archive imported into R, \code{pull_tweet_data()} uses the **rtweet**
#'   package to query the Twitter API. Using rtweet requires Twitter API keys
#'   associated with an approved developer account. Fortunately, the rtweet vignette,
#'   \href{https://rtweet.info/articles/auth.html}{Obtaining and using access tokens}, provides a very thorough guide
#'   to obtaining Twitter API keys. We recommend the second suggested method listed
#'   in the rtweet vignette, "2. Access token/secret method." Following these
#'   directions, you will run the \code{rtweet::create_token()} function, which
#'   saves your Twitter API keys to the \code{.Renviron} file. You can also edit
#'   this file directly using the \code{usethis::edit_r_environ(scope='user')} function.
#' @param df A dataframe of containing the column name 'status_url'
#'   (i.e., the hyperlink to specific tweets), such as that returned by
#'   \code{read_tags()}
#' @param url_vector A vector of tweet URLs, such as as those contained in
#'   the 'status_url' column of a dataframe returned by \code{tidytags::read_tags()}
#' @param id_vector A vector of tweet ID numbers, such as as those contained in
#'   the 'id_str' column of a dataframe returned by \code{tidytags::read_tags()}
#' @param n The number of tweets to look up, by default the total number of tweet
#'   ID numbers available, but capped at 90,000 due to Twitter API limitations.
#' @return A dataframe of tweets and full metadata from the Twitter API
#' @seealso Read more about \code{library(rtweet)} \href{https://rtweet.info/}{here}.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/"
#' pull_tweet_data(read_tags(example_url)[1:10, ])
#' pull_tweet_data(read_tags(example_url), n = 10)
#' pull_tweet_data(url_vector = read_tags(example_url)$status_url[1:10])
#' pull_tweet_data(url_vector = read_tags(example_url)$status_url, n = 10)
#' pull_tweet_data(id_vector = read_tags(example_url)$id_str[1:10])
#' pull_tweet_data(id_vector = read_tags(example_url)$id_str, n = 10)
#' pull_tweet_data(url_vector = "https://twitter.com/tweet__example/status/1176592704647716864")
#' pull_tweet_data(id_vector = "1176592704647716864")
#'
#' }
#' @export
pull_tweet_data <-
  function(df, url_vector = NULL, id_vector = NULL, n = NULL) {
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
               url_vector <- url_vector[1:90000]
               n <- length(url_vector)
             }

             new_df <- rtweet::lookup_statuses(get_char_tweet_ids(url_vector[1:n],
                                                                  url_vector = url_vector[1:n]
             )
             )
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
                      id_vector <- id_vector[1:90000]
                      n <- length(id_vector)
                    }

                    new_df <- rtweet::lookup_statuses(id_vector[1:n])
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
                      df <- df[1:90000, ]
                      n <- nrow(df)
                    }

                    new_df <- rtweet::lookup_statuses(get_char_tweet_ids(df[1:n, ]))
                  }

           )
    )

    new_df

  }

#' Retrieve the fullest extent of tweet metadata for more than 90,000 tweets
#'
#' This function calls \code{pull_tweet_data()}, but has a built-in delay
#'   of 15 minutes to allow the Twitter API to reset after looking up 90,000 tweets.
#' @param x A list or vector of tweet ID numbers
#' @param alarm An audible notification that a batch of 90,000 tweets has been
#'   completed
#' @return A dataframe of tweets and full metadata from the Twitter API
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
        beepr::beep(2)
      }
      if (n_batches > 1) {
        message("Processed batch: ", i)
      }
      if (i != n_batches) {
        message("Now sleeping...")
        Sys.sleep(901)
        message("Awake!")
      }
    }
    new_df
  }

#' Count the number of items in a list, with an NA entry returning 0
#'
#' @param x A list
#' @return The number of items in the list
length_with_na <-
  function(x) {
    ifelse(is.na(x), 0, purrr::map_int(x, length))
  }

#' Calculate additional information using tweet metadata
#'
#' @param df A dataframe of tweets and full metadata from the Twitter API as returned
#'   by \code{pull_tweet_data()}
#' @return A dataframe with several additional columns: word_count, character_count,
#'   mentions_count, hashtags_count_api, hashtags_count_regex, has_hashtags,
#'   urls_count_api, urls_count_regex, is_reply, is_self_reply
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/"
#' tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#' tmp_processed <- process_tweets(tmp_df)
#' tmp_processed
#'
#' }
#' @importFrom rlang .data
#' @export
process_tweets <-
  function(df) {
    url_regex <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
    hashtag_regex <- "#([0-9]|[a-zA-Z])+"
    df <-
      dplyr::mutate(df,
                    word_count = stringr::str_count(.data$text, "\\s+") + 1,
                    character_count = stringr::str_length(.data$text),
                    mentions_count = length_with_na(.data$mentions_screen_name),
                    hashtags_count_api = length_with_na(.data$hashtags),
                    hashtags_count_regex = stringr::str_count(.data$text, hashtag_regex), # more accurate than API
                    has_hashtags = dplyr::if_else(.data$hashtags_count_regex != 0, TRUE, FALSE),
                    urls_count_api = length_with_na(.data$urls_url),
                    urls_count_regex = stringr::str_count(.data$text, url_regex), # counts links to quoted tweets and media
                    is_reply = dplyr::if_else(!is.na(.data$reply_to_status_id), TRUE, FALSE),
                    is_self_reply = dplyr::if_else(
                      .data$is_reply,
                      dplyr::if_else(
                        .data$user_id == .data$reply_to_user_id,
                        TRUE,
                        FALSE
                      ),
                      FALSE
                    )
      )

    df <-
      dplyr::mutate_at(df,
                       dplyr::vars(dplyr::matches(c("status_id", "user_id", "screen_name"))),
                       as.character)

    df
  }
