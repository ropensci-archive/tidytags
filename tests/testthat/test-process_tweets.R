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

processed_tweet <- process_tweets(sample_tweet)

test_that("process_tweets() mutates and adds additional columns", {
  expect_true(is.data.frame(processed_tweet))
  expect_named(processed_tweet)
  expect_true("user_id" %in% names(processed_tweet))
  expect_true("status_id" %in% names(processed_tweet))
  expect_true("word_count" %in% names(processed_tweet))
  expect_true("is_reply" %in% names(processed_tweet))
  expect_gt(ncol(processed_tweet), ncol(sample_tweet))
  expect_equal(nrow(processed_tweet), nrow(sample_tweet))
  expect_equal(processed_tweet$screen_name, sample_tweet$screen_name)
})
