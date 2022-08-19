test_that("process_tweets() mutates and adds additional columns", {

  vcr::use_cassette("sample_tags", {
    example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
    sample_tags <- head(read_tags(example_url), 200)
    sample_tags <- sample_tags[,1:(length(sample_tags)-1)]
  })

  vcr::use_cassette("metadata_from_rtweet", {
    app <- rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
    rtweet::auth_as(app)
    from_df <- pull_tweet_data(sample_tags, n = 10)
  })

  more_info <- from_df
  processed_data <- process_tweets(more_info)

  testthat::expect_equal(is.data.frame(processed_data), TRUE)
  testthat::expect_named(processed_data)
  testthat::expect_true("created_at" %in% names(processed_data))
  testthat::expect_true("id_str" %in% names(processed_data))
  testthat::expect_true("full_text" %in% names(processed_data))
  testthat::expect_true("entities" %in% names(processed_data))
  testthat::expect_true("in_reply_to_status_id_str" %in% names(processed_data))
  testthat::expect_true("user_id_str" %in% names(processed_data))
  testthat::expect_true("screen_name" %in% names(processed_data))
  testthat::expect_true("location" %in% names(processed_data))
  testthat::expect_true("followers_count" %in% names(processed_data))
  testthat::expect_true("friends_count" %in% names(processed_data))
  testthat::expect_true("mentions_count" %in% names(processed_data))
  testthat::expect_true("hashtags_count" %in% names(processed_data))
  testthat::expect_true("urls_count" %in% names(processed_data))
  testthat::expect_true("tweet_type" %in% names(processed_data))
  testthat::expect_true("is_self_reply" %in% names(processed_data))
  testthat::expect_gt(ncol(processed_data), ncol(more_info))
  testthat::expect_equal(nrow(processed_data), nrow(more_info))
  testthat::expect_equal(processed_data$id_str, more_info$id_str)
})


