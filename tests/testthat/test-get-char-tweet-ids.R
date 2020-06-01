context("Get character tweet IDs")
library(tidytags)

#flatten_list <-
#  function(x) {paste(unlist(x), collapse=" ")}
#sample_tags_sheet <-
#  "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/"
#sample_df <-
#  pull_tweet_data(read_tags(sample_tags_sheet), n = 10)

#sample_data <-
#  tibble::as_tibble(sample_df) %>%
#  dplyr::mutate_if(is.list, flatten_list)
#readr::write_csv(sample_data, "tests/sample-data.csv")
#sample_tweet <-
#  tibble::as_tibble(sample_df[2, ]) %>%
#  dplyr::mutate_if(is.list, flatten_list)
#readr::write_csv(sample_tweet, "tests/sample-tweet.csv")

sample_data <-
  readr::read_csv("sample-data.csv",
                  col_names = TRUE,
                  col_types = readr::cols(user_id = readr::col_character(),
                                          status_id = readr::col_character(),
                                          retweet_status_id = readr::col_character(),
                                          quoted_status_id = readr::col_character(),
                                          reply_to_status_id = readr::col_character()
                  )
  )
sample_tweet <-
  readr::read_csv("sample-tweet.csv",
                  col_names = TRUE,
                  col_types = readr::cols(user_id = readr::col_character(),
                                          status_id = readr::col_character(),
                                          retweet_status_id = readr::col_character(),
                                          quoted_status_id = readr::col_character(),
                                          reply_to_status_id = readr::col_character()
                  )
  )


test_that("get_char_tweet_ids() extracts correct ID number", {
  expect_equal(get_char_tweet_ids(sample_tweet), "1219758386436165633")
  expect_equal(get_char_tweet_ids(url_vector = sample_tweet$status_url), "1219758386436165633")
  expect_equal(get_char_tweet_ids(sample_data[8, ]), "1225137879921385472")
  expect_equal(get_char_tweet_ids(url_vector = sample_data$status_url[8]), "1225137879921385472")
})
