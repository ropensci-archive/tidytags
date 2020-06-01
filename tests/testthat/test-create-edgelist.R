context("Create edgelist")
library(tidytags)

sample_tags_sheet <-
  "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/"
sample_df <-
  pull_tweet_data(read_tags(sample_tags_sheet), n = 10)
el <- create_edgelist(sample_df)


sample_edgelist <-
  tibble::tibble(sender = c("gsa_aect", "gsa_aect"),
                 receiver = c("AECT", "AECT"),
                 edge_type = c("retweet", "mention")
  )


test_that("tweets build into edgelist", {
  expect_equal(el, sample_edgelist)
  expect_equal(is.data.frame(el), TRUE)
  expect_named(el)
  expect_true("sender" %in% names(el))
  expect_true("receiver" %in% names(el))
  expect_true("edge_type" %in% names(el))
})
