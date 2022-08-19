test_that("lookup_many_tweets() works like pull_tweet_data()", {

  vcr::use_cassette("sample_tags", {
    example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
    sample_tags <- head(read_tags(example_url), 200)
    sample_tags <- sample_tags[,1:(length(sample_tags)-1)]
  })

  vcr::use_cassette("lookup_many", {
    app <- rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
    rtweet::auth_as(app)
    pull_regular <- pull_tweet_data(sample_tags, n = 10)
    pull_many <- lookup_many_tweets(sample_tags$id_str[1:10])
  })

  testthat::expect_equal(is.data.frame(pull_many), TRUE)
  testthat::expect_named(pull_many)
  testthat::expect_true("created_at" %in% names(pull_many))
  testthat::expect_true("id_str" %in% names(pull_many))
  testthat::expect_true("full_text" %in% names(pull_many))
  testthat::expect_true("entities" %in% names(pull_many))
  testthat::expect_true("in_reply_to_status_id_str" %in% names(pull_many))
  testthat::expect_true("user_id_str" %in% names(pull_many))
  testthat::expect_true("screen_name" %in% names(pull_many))
  testthat::expect_true("location" %in% names(pull_many))
  testthat::expect_true("followers_count" %in% names(pull_many))
  testthat::expect_true("friends_count" %in% names(pull_many))
  testthat::expect_gt(ncol(pull_many), ncol(sample_tags))
  testthat::expect_lte(nrow(pull_many), nrow(sample_tags))
  testthat::expect_equal(ncol(pull_many), ncol(pull_regular))
  testthat::expect_equal(nrow(pull_many), nrow(pull_regular))
  testthat::expect_equal(pull_many$created_at, pull_regular$created_at)
  testthat::expect_equal(pull_many$id_str, pull_regular$id_str)
})
