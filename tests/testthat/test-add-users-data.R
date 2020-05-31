context("Add users' data")
library(tidytags)

test_that("user data is added properly", {
  skip_on_cran()

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
  el_plus <- add_users_data(el)

  expect_equal(is.data.frame(el_plus), TRUE)
  expect_named(el_plus)
  expect_true("sender" %in% names(el_plus))
  expect_true("user_id_sender" %in% names(el_plus))
  expect_true("receiver" %in% names(el_plus))
  expect_true("user_id_receiver" %in% names(el_plus))
  expect_true("edge_type" %in% names(el_plus))
  expect_gt(ncol(el_plus), ncol(el))
  expect_equal(nrow(el_plus), nrow(el))
  expect_equal(el_plus$sender, el$sender)
  expect_equal(el_plus$receiver, el$receiver)
})
