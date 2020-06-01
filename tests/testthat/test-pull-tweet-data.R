context("Pull additional tweet data")
library(tidytags)


test_that("pull_tweet_data() is able to retrieve additional metadata starting with dataframe", {
  skip_on_cran()

  example_url <- "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/edit#gid=8743918"
  x <- read_tags(example_url)
  n_tweets <- 10

  y_from_df <- pull_tweet_data(x, n = n_tweets)

  expect_equal(is.data.frame(y_from_df), TRUE)
  expect_named(y_from_df)
  expect_true("user_id" %in% names(y_from_df))
  expect_true("status_id" %in% names(y_from_df))
  expect_true("status_url" %in% names(y_from_df))
  expect_true("reply_to_status_id" %in% names(y_from_df))
  expect_gt(ncol(y_from_df), ncol(x))
  expect_gt(n_tweets + 1, nrow(y_from_df))
})


test_that("pull_tweet_data() is able to retrieve additional metadata starting with tweet IDs", {
  skip_on_cran()

  example_url <- "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/edit#gid=8743918"
  x <- read_tags(example_url)
  n_tweets <- 10

  y_from_ids <- pull_tweet_data(id_vector = x$id_str, n = n_tweets)

  expect_equal(is.data.frame(y_from_ids), TRUE)
  expect_named(y_from_ids)
  expect_true("user_id" %in% names(y_from_ids))
  expect_true("status_id" %in% names(y_from_ids))
  expect_true("status_url" %in% names(y_from_ids))
  expect_true("reply_to_status_id" %in% names(y_from_ids))
  expect_gt(ncol(y_from_ids), ncol(x))
  expect_gt(n_tweets + 1, nrow(y_from_ids))
})


test_that("pull_tweet_data() is able to retrieve additional metadata starting with tweet URLs", {
  skip_on_cran()

  example_url <- "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/"
  x <- read_tags(example_url)
  n_tweets <- 10

  y_from_urls <- pull_tweet_data(url_vector = x$status_url, n = n_tweets)

  expect_true(is.data.frame(y_from_urls))
  expect_named(y_from_urls)
  expect_true("user_id" %in% names(y_from_urls))
  expect_true("status_id" %in% names(y_from_urls))
  expect_true("status_url" %in% names(y_from_urls))
  expect_true("reply_to_status_id" %in% names(y_from_urls))
  expect_gt(ncol(y_from_urls), ncol(x))
  expect_gt(n_tweets + 1, nrow(y_from_urls))
})
