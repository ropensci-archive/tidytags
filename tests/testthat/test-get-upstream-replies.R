context("Get upstream replies")
library(tidytags)


test_that("get_upstream_replies() finds additional replies", {
  skip_on_travis()
  skip_on_cran()

  example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
  x <- read_tags(example_url)
  y <- pull_tweet_data(x)
  replies <- dplyr::filter(y, !is.na(reply_to_status_id))
  replies_plus <- get_upstream_replies(replies)

  expect_true(is.data.frame(replies_plus))
  expect_named(replies_plus)
  expect_true("user_id" %in% names(replies_plus))
  expect_true("status_id" %in% names(replies_plus))
  expect_true("status_url" %in% names(replies_plus))
  expect_true("reply_to_status_id" %in% names(replies_plus))
  expect_gt(ncol(replies_plus), ncol(x))
  expect_gte(ncol(replies_plus), ncol(replies))
  expect_gte(nrow(replies_plus), nrow(replies))
})


test_that("get_upstream_replies() works with no new replies found", {
  skip_on_travis()
  skip_on_cran()

  sample_data <-
    readr::read_csv("sample-data.csv",
      col_names = TRUE,
      col_types = readr::cols(
        user_id = readr::col_character(),
        status_id = readr::col_character(),
        retweet_status_id = readr::col_character(),
        quoted_status_id = readr::col_character(),
        reply_to_status_id = readr::col_character()
      )
    )
  replies_plus <- get_upstream_replies(sample_data)

  expect_equal(is.data.frame(replies_plus), TRUE)
  expect_named(replies_plus)
  expect_true("user_id" %in% names(replies_plus))
  expect_true("status_id" %in% names(replies_plus))
  expect_true("status_url" %in% names(replies_plus))
  expect_true("reply_to_status_id" %in% names(replies_plus))
  expect_gt(ncol(replies_plus), ncol(sample_data))
  expect_gte(ncol(replies_plus), ncol(sample_data))
  expect_gte(nrow(replies_plus), nrow(sample_data))
})
