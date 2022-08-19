test_that("pull_tweet_data() is able to retrieve additional metadata starting
          with dataframe", {

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

  testthat::expect_equal(is.data.frame(from_df), TRUE)
  testthat::expect_named(from_df)
  testthat::expect_true("created_at" %in% names(from_df))
  testthat::expect_true("id_str" %in% names(from_df))
  testthat::expect_true("full_text" %in% names(from_df))
  testthat::expect_true("entities" %in% names(from_df))
  testthat::expect_true("in_reply_to_status_id_str" %in% names(from_df))
  testthat::expect_true("user_id_str" %in% names(from_df))
  testthat::expect_true("screen_name" %in% names(from_df))
  testthat::expect_true("location" %in% names(from_df))
  testthat::expect_true("followers_count" %in% names(from_df))
  testthat::expect_true("friends_count" %in% names(from_df))
  testthat::expect_gt(ncol(from_df), ncol(sample_tags))
  testthat::expect_lte(nrow(from_df), nrow(sample_tags))
})



test_that("pull_tweet_data() is able to retrieve additional metadata starting
          with tweet IDs", {

  vcr::use_cassette("sample_tags", {
    sample_tags <- read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
  })

  vcr::use_cassette("metadata_from_ids", {
    app <- rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
    rtweet::auth_as(app)
    from_ids <- pull_tweet_data(id_vector = sample_tags$id_str, n = 10)
  })

  testthat::expect_equal(is.data.frame(from_ids), TRUE)
  testthat::expect_named(from_ids)
  testthat::expect_true("created_at" %in% names(from_ids))
  testthat::expect_true("id_str" %in% names(from_ids))
  testthat::expect_true("full_text" %in% names(from_ids))
  testthat::expect_true("entities" %in% names(from_ids))
  testthat::expect_true("in_reply_to_status_id_str" %in% names(from_ids))
  testthat::expect_true("user_id_str" %in% names(from_ids))
  testthat::expect_true("screen_name" %in% names(from_ids))
  testthat::expect_true("location" %in% names(from_ids))
  testthat::expect_true("followers_count" %in% names(from_ids))
  testthat::expect_true("friends_count" %in% names(from_ids))
  testthat::expect_gt(ncol(from_ids), ncol(sample_tags))
  testthat::expect_lte(nrow(from_ids), nrow(sample_tags))
})



test_that("pull_tweet_data() is able to retrieve additional metadata starting
          with tweet URLs", {

  vcr::use_cassette("sample_tags", {
    sample_tags <- read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
  })

  vcr::use_cassette("metadata_from_urls", {
    app <- rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
    rtweet::auth_as(app)
    from_urls <- pull_tweet_data(url_vector = sample_tags$status_url, n = 10)
  })

  testthat::expect_equal(is.data.frame(from_urls), TRUE)
  testthat::expect_named(from_urls)
  testthat::expect_true("created_at" %in% names(from_urls))
  testthat::expect_true("id_str" %in% names(from_urls))
  testthat::expect_true("full_text" %in% names(from_urls))
  testthat::expect_true("entities" %in% names(from_urls))
  testthat::expect_true("in_reply_to_status_id_str" %in% names(from_urls))
  testthat::expect_true("user_id_str" %in% names(from_urls))
  testthat::expect_true("screen_name" %in% names(from_urls))
  testthat::expect_true("location" %in% names(from_urls))
  testthat::expect_true("followers_count" %in% names(from_urls))
  testthat::expect_true("friends_count" %in% names(from_urls))
  testthat::expect_gt(ncol(from_urls), ncol(sample_tags))
  testthat::expect_lte(nrow(from_urls), nrow(sample_tags))
})
