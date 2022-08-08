vcr::use_cassette("sample_tags", {
  sample_tags <- read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
})

vcr::use_cassette("different_tweet_types", {
  app <- rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
  rtweet::auth_as(app)
  more_info <- pull_tweet_data(sample_tags, n = 100)
})

processed_data <- process_tweets(more_info)



test_that("filter works for replies", {

  filtered_df <- filter_by_tweet_type(processed_data, "reply")

  testthat::expect_equal(is.data.frame(filtered_df), TRUE)
  testthat::expect_named(filtered_df)
  testthat::expect_true("created_at" %in% names(filtered_df))
  testthat::expect_true("id_str" %in% names(filtered_df))
  testthat::expect_true("full_text" %in% names(filtered_df))
  testthat::expect_true("entities" %in% names(filtered_df))
  testthat::expect_true("mentions_count" %in% names(filtered_df))
  testthat::expect_true("hashtags_count" %in% names(filtered_df))
  testthat::expect_true("urls_count" %in% names(filtered_df))
  testthat::expect_true("tweet_type" %in% names(filtered_df))
  testthat::expect_true("is_self_reply" %in% names(filtered_df))
  testthat::expect_gt(ncol(filtered_df), ncol(more_info))
  testthat::expect_equal(ncol(filtered_df), ncol(processed_data))
  testthat::expect_lte(nrow(filtered_df), nrow(processed_data))
  testthat::expect_equal(filtered_df$tweet_type[1], "reply")
})



test_that("filter works for retweets", {

  filtered_df <- filter_by_tweet_type(processed_data, "retweet")

  testthat::expect_equal(is.data.frame(filtered_df), TRUE)
  testthat::expect_named(filtered_df)
  testthat::expect_true("created_at" %in% names(filtered_df))
  testthat::expect_true("id_str" %in% names(filtered_df))
  testthat::expect_true("full_text" %in% names(filtered_df))
  testthat::expect_true("entities" %in% names(filtered_df))
  testthat::expect_true("mentions_count" %in% names(filtered_df))
  testthat::expect_true("hashtags_count" %in% names(filtered_df))
  testthat::expect_true("urls_count" %in% names(filtered_df))
  testthat::expect_true("tweet_type" %in% names(filtered_df))
  testthat::expect_true("is_self_reply" %in% names(filtered_df))
  testthat::expect_gt(ncol(filtered_df), ncol(more_info))
  testthat::expect_equal(ncol(filtered_df), ncol(processed_data))
  testthat::expect_lte(nrow(filtered_df), nrow(processed_data))
  testthat::expect_equal(filtered_df$tweet_type[1], "retweet")
})



test_that("filter works for quote tweets", {

  filtered_df <- filter_by_tweet_type(processed_data, "quote")

  testthat::expect_equal(is.data.frame(filtered_df), TRUE)
  testthat::expect_named(filtered_df)
  testthat::expect_true("created_at" %in% names(filtered_df))
  testthat::expect_true("id_str" %in% names(filtered_df))
  testthat::expect_true("full_text" %in% names(filtered_df))
  testthat::expect_true("entities" %in% names(filtered_df))
  testthat::expect_true("in_reply_to_status_id_str" %in% names(filtered_df))
  testthat::expect_true("user_id_str" %in% names(filtered_df))
  testthat::expect_true("screen_name" %in% names(filtered_df))
  testthat::expect_true("location" %in% names(filtered_df))
  testthat::expect_true("followers_count" %in% names(filtered_df))
  testthat::expect_true("friends_count" %in% names(filtered_df))
  testthat::expect_true("mentions_count" %in% names(filtered_df))
  testthat::expect_true("hashtags_count" %in% names(filtered_df))
  testthat::expect_true("urls_count" %in% names(filtered_df))
  testthat::expect_true("tweet_type" %in% names(filtered_df))
  testthat::expect_true("is_self_reply" %in% names(filtered_df))
  testthat::expect_gt(ncol(filtered_df), ncol(more_info))
  testthat::expect_equal(ncol(filtered_df), ncol(processed_data))
  testthat::expect_lte(nrow(filtered_df), nrow(processed_data))
  testthat::expect_equal(filtered_df$tweet_type[1], "quote")
})



test_that("filter works for original tweets", {

  filtered_df <- filter_by_tweet_type(processed_data, "original")

  testthat::expect_equal(is.data.frame(filtered_df), TRUE)
  testthat::expect_named(filtered_df)
  testthat::expect_true("created_at" %in% names(filtered_df))
  testthat::expect_true("id_str" %in% names(filtered_df))
  testthat::expect_true("full_text" %in% names(filtered_df))
  testthat::expect_true("entities" %in% names(filtered_df))
  testthat::expect_true("in_reply_to_status_id_str" %in% names(filtered_df))
  testthat::expect_true("user_id_str" %in% names(filtered_df))
  testthat::expect_true("screen_name" %in% names(filtered_df))
  testthat::expect_true("location" %in% names(filtered_df))
  testthat::expect_true("followers_count" %in% names(filtered_df))
  testthat::expect_true("friends_count" %in% names(filtered_df))
  testthat::expect_true("mentions_count" %in% names(filtered_df))
  testthat::expect_true("hashtags_count" %in% names(filtered_df))
  testthat::expect_true("urls_count" %in% names(filtered_df))
  testthat::expect_true("tweet_type" %in% names(filtered_df))
  testthat::expect_true("is_self_reply" %in% names(filtered_df))
  testthat::expect_gt(ncol(filtered_df), ncol(more_info))
  testthat::expect_equal(ncol(filtered_df), ncol(processed_data))
  testthat::expect_lte(nrow(filtered_df), nrow(processed_data))
  testthat::expect_equal(filtered_df$tweet_type[1], "original")
})
