context("Pull additional tweet data")
library(tidytags)

test_that("lookup_many_tweets() retrieves additional metadata like pull_tweet_data()", {
  skip_on_covr()
  skip_on_cran()

  example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
  x <- read_tags(example_url)
  n_tweets <- 10

  ids <- x$id_str[1:n_tweets]
  y <- lookup_many_tweets(ids)
  z <- pull_tweet_data(id_vector = ids)

  expect_true(is.data.frame(y))
  expect_named(y)
  expect_true("user_id" %in% names(y))
  expect_true("status_id" %in% names(y))
  expect_true("status_url" %in% names(y))
  expect_true("reply_to_status_id" %in% names(y))
  expect_gt(ncol(y), ncol(x))
  expect_gt(n_tweets + 1, nrow(y))
  expect_equal(y$user_id, z$user_id)
  expect_equal(y$status_id, z$status_id)
})
