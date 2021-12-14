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


test_that("filter works for replies", {

  filtered_df <- filter_by_tweet_type(sample_data, "reply")

  expect_true(is.data.frame(filtered_df))
  expect_named(filtered_df)
  expect_true("user_id" %in% names(filtered_df))
  expect_true("status_id" %in% names(filtered_df))
  expect_true("word_count" %in% names(filtered_df))
  expect_true("is_reply" %in% names(filtered_df))
  expect_gt(ncol(filtered_df), ncol(sample_data))
  expect_lte(nrow(filtered_df), nrow(sample_data))
})


test_that("filter works for retweets", {

  filtered_df <- filter_by_tweet_type(sample_data, "retweet")

  expect_true(is.data.frame(filtered_df))
  expect_named(filtered_df)
  expect_true("user_id" %in% names(filtered_df))
  expect_true("status_id" %in% names(filtered_df))
  expect_true("word_count" %in% names(filtered_df))
  expect_true("is_reply" %in% names(filtered_df))
  expect_gt(ncol(filtered_df), ncol(sample_data))
  expect_lte(nrow(filtered_df), nrow(sample_data))
})


test_that("filter works for quote tweets", {

  filtered_df <- filter_by_tweet_type(sample_data, "quote")

  expect_true(is.data.frame(filtered_df))
  expect_named(filtered_df)
  expect_true("user_id" %in% names(filtered_df))
  expect_true("status_id" %in% names(filtered_df))
  expect_true("word_count" %in% names(filtered_df))
  expect_true("is_reply" %in% names(filtered_df))
  expect_gt(ncol(filtered_df), ncol(sample_data))
  expect_lte(nrow(filtered_df), nrow(sample_data))
})


test_that("filter works for mentions", {

  filtered_df <- filter_by_tweet_type(sample_data, "mention")

  expect_true(is.data.frame(filtered_df))
  expect_named(filtered_df)
  expect_true("user_id" %in% names(filtered_df))
  expect_true("status_id" %in% names(filtered_df))
  expect_true("word_count" %in% names(filtered_df))
  expect_true("is_reply" %in% names(filtered_df))
  expect_gt(ncol(filtered_df), ncol(sample_data))
  expect_lte(nrow(filtered_df), nrow(sample_data))
})
