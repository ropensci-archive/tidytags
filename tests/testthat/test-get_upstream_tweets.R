test_that("get_upstream_tweets() finds additional tweets", {
  vcr::use_cassette("upstream_tweets", {
    tags_data <- read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
    more_info <- pull_tweet_data(tags_data)
    replies <- head(dplyr::filter(more_info, !is.na(reply_to_status_id)), 10)
    replies_plus <- get_upstream_tweets(replies)
  })

  expect_true(is.data.frame(replies_plus))
  expect_named(replies_plus)
  expect_true("user_id" %in% names(replies_plus))
  expect_true("status_id" %in% names(replies_plus))
  expect_true("status_url" %in% names(replies_plus))
  expect_true("reply_to_status_id" %in% names(replies_plus))
  expect_gt(ncol(replies_plus), ncol(tags_data))
  expect_gte(ncol(replies_plus), ncol(replies))
  expect_gte(nrow(replies_plus), nrow(replies))
})


test_that("get_upstream_tweets() works with no new replies found", {
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

  vcr::use_cassette("upstream_replies_empty", {
    replies_plus <- get_upstream_tweets(sample_data)
  })

  expect_equal(is.data.frame(replies_plus), TRUE)
  expect_named(replies_plus)
  expect_true("user_id" %in% names(replies_plus))
  expect_true("status_id" %in% names(replies_plus))
  expect_true("status_url" %in% names(replies_plus))
  expect_true("reply_to_status_id" %in% names(replies_plus))
  expect_equal(ncol(replies_plus), ncol(sample_data))
  expect_equal(nrow(replies_plus), nrow(sample_data))
  expect_equal(replies_plus, sample_data)
})
