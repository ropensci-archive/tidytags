context("Process tweets")
library(tidytags)

sample_tweet <-
  readr::read_csv("sample-tweet.csv",
    col_names = TRUE,
    col_types = readr::cols(
      user_id = readr::col_character(),
      status_id = readr::col_character(),
      retweet_status_id = readr::col_character(),
      quoted_status_id = readr::col_character(),
      reply_to_status_id = readr::col_character()
    )
  )

x <- process_tweets(sample_tweet)


test_that("process_tweets() mutates and adds additional columns", {
  expect_true(is.data.frame(x))
  expect_named(x)
  expect_true("user_id" %in% names(x))
  expect_true("status_id" %in% names(x))
  expect_true("word_count" %in% names(x))
  expect_true("is_reply" %in% names(x))
  expect_gt(ncol(x), ncol(sample_tweet))
  expect_equal(nrow(x), nrow(sample_tweet))
  expect_equal(x$screen_name, sample_tweet$screen_name)
})
