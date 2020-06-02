context("Create edgelist")
library(tidytags)

test_that("tweets build into edgelist", {
  skip_on_travis()
  skip_on_cran()

  sample_tags_sheet <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
  sample_df <-
    pull_tweet_data(read_tags(sample_tags_sheet), n = 10)
  el <- create_edgelist(sample_df)

  expect_true(is.data.frame(el))
  expect_named(el)
  expect_true("sender" %in% names(el))
  expect_true("receiver" %in% names(el))
  expect_true("edge_type" %in% names(el))
  expect_true("gsa_aect" %in% el$sender)
  expect_true("AECT" %in% el$receiver)
  expect_true("retweet" %in% el$edge_type)
})
