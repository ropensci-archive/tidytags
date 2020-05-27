context("Process tweets")
library(tidytags)

check_api <-
  function() {
    if (not_working()) {
      skip("API not available")
    }
  }

sample_tags <-
  "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/edit#gid=8743918"
sample_df <-
  process_tweets(pull_tweet_data(read_tags(sample_tags), n = 10))

test_that("str_length is number of characters", {
  expect_equal(process_tweets(), 1)
})


test_that("get_char_tweet_ids() works from TAGS", {
  check_api()
  expect_equal(get_char_tweet_ids(sample_df)[2], "1219758386436165633")
})
