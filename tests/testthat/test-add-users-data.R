context("Add users' data")
library(tidytags)

check_api <- function() {
  if (not_working()) {
    skip("API not available")
  }
}

sample_tweet <-
  readr::read_csv("tests/sample-tweet.csv",
                  col_names = TRUE,
                  col_types = readr::cols(user_id = readr::col_character(),
                                          status_id = readr::col_character(),
                                          retweet_status_id = readr::col_character(),
                                          quoted_status_id = readr::col_character(),
                                          reply_to_status_id = readr::col_character()
                  )
  )



#reate_edgelist(sample_tweet)
#rtweet::users_data(sample_tweet)
#add_users_data(create_edgelist(sample_tweet), rtweet::users_data(sample_tweet))



test_that("user data is added properly", {
  check_api()
  expect_equal(get_char_tweet_ids(sample_df)[2], "1219758386436165633")
})
