context("Create edgelist")
library(tidytags)

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

el <- create_edgelist(sample_tweet)


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
