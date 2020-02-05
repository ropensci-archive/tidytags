## Read more about library(googlesheets) at https://github.com/jennybc/googlesheets
## Read more about library(rtweet) at https://rtweet.info/


`%notin%` <- Negate(`%in%`)
url_regex <- "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
hashtag_regex <- "#([0-9]|[a-zA-Z])+"


read_tags <- function(url) {
  full_workbook <- googlesheets::gs_url(url)
  one_sheet <- googlesheets::gs_read(full_workbook, ws = 2)
  one_sheet
}


get_char_tweet_ids <- function(df) {
  df <- dplyr::mutate(df,
                status_id_char = stringr::str_split_fixed(status_url, "/", n=6)[ ,6]
                )
  dplyr::pull(df, status_id_char)
}


pull_tweet_data <- function(x, n = NULL) {
  if(is.null(n)) {n <- length(x)}
  if (length(x) > 90000) {
    warning("Twitter API only allows lookup of 90,000 tweets at a time;",
            "collecting data for first 90,000 tweet IDs.",
            "To process more, use `lookup_many_tweets()`.")
    x <- x[1:90000]
  }
  new_df <- rtweet::lookup_statuses(x[1:n])
  new_df
}


lookup_many_tweets <- function(df, alarm = FALSE) {
  n_batches <- ceiling(nrow(df) / 90000)
  new_df <- data.frame()
  for(i in 1:n_batches) {
    min_id <- 90000*i - 89999
    max_id <- dplyr::if_else(90000*i < nrow(df), 90000*i, nrow(df))
    tmp_df <- pull_tweet_data(df[min_id:max_id, ]) #purrr::flatten() %>%
    new_df <- rbind(new_df, tmp_df)
    if(alarm == TRUE) {beepr::beep(2)}
    if(n_batches > 1) {message("Processed batch: ", i)}
    if (i != n_batches) {message("Now sleeping..."); Sys.sleep(901); message("Awake!")}
  }
  new_df
}


length_with_na <- function(x) {
  dplyr::if_else(is.na(x), 0, purrr::map_int(x, length))
}


process_tweets <- function(df) {
  dplyr::mutate(df,
                word_count = stringr::str_count(text, "\\s+") + 1,
                character_count = stringr::str_length(text),
                mentions_count = length_with_na(mentions_screen_name),
                hashtags_count_api = length_with_na(hashtags),
                hashtags_count_regex = stringr::str_count(text, hashtag_regex),  # more accurate than API
                has_hashtags = dplyr::if_else(hashtags_count_regex != 0, TRUE, FALSE),
                urls_count_api = length_with_na(urls_url),
                urls_count_regex = stringr::str_count(text, url_regex),  # counts links to quoted tweets and media
                is_reply = dplyr::if_else(!is.na(reply_to_status_id), TRUE, FALSE),
                is_self_reply = dplyr::if_else(is_reply,
                                              dplyr::if_else(user_id==reply_to_user_id,
                                                            TRUE,
                                                            FALSE),
                                              FALSE
                                              )
                )
}


process_tweets_flattened <- function(df) {
  dplyr::mutate(df,
                word_count = stringr::str_count(text, "\\s+") + 1,
                character_count = stringr::str_length(text),
                mentions_count = length_with_na(str_split(mentions_screen_name, " ")),
                hashtags_count_api = length_with_na(str_split(hashtags, " ")),
                hashtags_count_regex = stringr::str_count(text, hashtag_regex),  # more accurate than API
                has_hashtags = dplyr::if_else(hashtags_count_regex != 0, TRUE, FALSE),
                urls_count_api = length_with_na(str_split(urls_url, " ")),
                urls_count_regex = stringr::str_count(text, url_regex),  # counts links to quoted tweets and media
                is_reply = dplyr::if_else(!is.na(reply_to_status_id), TRUE, FALSE),
                is_self_reply = dplyr::if_else(is_reply,
                                              dplyr::if_else(user_id==reply_to_user_id,
                                                            TRUE,
                                                            FALSE),
                                              FALSE
                                              )
                )
}
