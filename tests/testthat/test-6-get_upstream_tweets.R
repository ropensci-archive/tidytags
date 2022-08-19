test_that("get_upstream_tweets() finds additional tweets", {

  vcr::use_cassette("sample_tags", {
    example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
    sample_tags <- head(read_tags(example_url), 200)
    sample_tags <- sample_tags[,1:(length(sample_tags)-1)]
  })

  vcr::use_cassette("upstream_tweets", {
    app <- rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
    rtweet::auth_as(app)
    more_info <- pull_tweet_data(sample_tags)
    replies_plus <- get_upstream_tweets(more_info)
  })

  testthat::expect_equal(is.data.frame(replies_plus), TRUE)
  testthat::expect_named(replies_plus)
  testthat::expect_true("created_at" %in% names(replies_plus))
  testthat::expect_true("id_str" %in% names(replies_plus))
  testthat::expect_true("full_text" %in% names(replies_plus))
  testthat::expect_true("entities" %in% names(replies_plus))
  testthat::expect_true("in_reply_to_status_id_str" %in% names(replies_plus))
  testthat::expect_true("user_id_str" %in% names(replies_plus))
  testthat::expect_true("screen_name" %in% names(replies_plus))
  testthat::expect_true("location" %in% names(replies_plus))
  testthat::expect_true("followers_count" %in% names(replies_plus))
  testthat::expect_true("friends_count" %in% names(replies_plus))
  testthat::expect_gt(ncol(replies_plus), ncol(sample_tags))
  testthat::expect_lte(nrow(replies_plus), nrow(sample_tags))
  testthat::expect_equal(ncol(replies_plus), ncol(more_info))
  testthat::expect_gte(nrow(replies_plus), nrow(more_info))
})


test_that("get_upstream_tweets() works with no new replies found", {
  sample_data <-
    readr::read_csv("sample-data.csv", col_names = TRUE)

  vcr::use_cassette("upstream_tweets_empty", {
    app <- rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
    rtweet::auth_as(app)
    more_info <- pull_tweet_data(sample_data)
    replies_plus <- get_upstream_tweets(more_info)
  })

  testthat::expect_equal(is.data.frame(replies_plus), TRUE)
  testthat::expect_named(replies_plus)
  testthat::expect_true("created_at" %in% names(replies_plus))
  testthat::expect_true("id_str" %in% names(replies_plus))
  testthat::expect_true("full_text" %in% names(replies_plus))
  testthat::expect_true("entities" %in% names(replies_plus))
  testthat::expect_true("in_reply_to_status_id_str" %in% names(replies_plus))
  testthat::expect_true("user_id_str" %in% names(replies_plus))
  testthat::expect_true("screen_name" %in% names(replies_plus))
  testthat::expect_true("location" %in% names(replies_plus))
  testthat::expect_true("followers_count" %in% names(replies_plus))
  testthat::expect_true("friends_count" %in% names(replies_plus))
  testthat::expect_equal(ncol(replies_plus), ncol(more_info))
  testthat::expect_equal(nrow(replies_plus), nrow(more_info))
  testthat::expect_equal(replies_plus, more_info)
})
