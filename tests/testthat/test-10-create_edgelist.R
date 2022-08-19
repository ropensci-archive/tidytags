vcr::use_cassette("sample_tags", {
  example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
  sample_tags <- head(read_tags(example_url), 200)
  sample_tags <- sample_tags[,1:(length(sample_tags)-1)]
})

vcr::use_cassette("different_tweet_types", {
  app <- rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
  rtweet::auth_as(app)
  more_info <- pull_tweet_data(sample_tags, n = 100)
})

processed_data <- process_tweets(more_info)



test_that("tweets build into edgelist with default parameter", {

  el <- create_edgelist(processed_data)

  testthat::expect_equal(is.data.frame(el), TRUE)
  testthat::expect_named(el)
  testthat::expect_true("sender" %in% names(el))
  testthat::expect_true("receiver" %in% names(el))
  testthat::expect_true("tweet_type" %in% names(el))
  testthat::expect_false("id_str" %in% names(el))
  testthat::expect_false("user_id_str" %in% names(el))
  testthat::expect_false("screen_name" %in% names(el))
  testthat::expect_true("gsa_aect" %in% el$sender)
  testthat::expect_true("AECT" %in% el$receiver)
  testthat::expect_true("RoutledgeEd" %in% el$receiver)
  testthat::expect_true("reply" %in% el$tweet_type)
  testthat::expect_true("retweet" %in% el$tweet_type)
  testthat::expect_true("quote" %in% el$tweet_type)

})



test_that("tweets build into edgelist with replies", {

  el <- create_edgelist(processed_data, type = "reply")

  testthat::expect_equal(is.data.frame(el), TRUE)
  testthat::expect_named(el)
  testthat::expect_true("sender" %in% names(el))
  testthat::expect_true("receiver" %in% names(el))
  testthat::expect_true("tweet_type" %in% names(el))
  testthat::expect_false("id_str" %in% names(el))
  testthat::expect_false("user_id_str" %in% names(el))
  testthat::expect_false("screen_name" %in% names(el))
  testthat::expect_false("gsa_aect" %in% el$sender)
  testthat::expect_false("AECT" %in% el$receiver)
  testthat::expect_false("RoutledgeEd" %in% el$receiver)
  testthat::expect_true("reply" %in% el$tweet_type)
  testthat::expect_false("retweet" %in% el$tweet_type)
  testthat::expect_false("quote" %in% el$tweet_type)
})



test_that("tweets build into edgelist with retweets", {

  el <- create_edgelist(processed_data, type = "retweet")

  testthat::expect_equal(is.data.frame(el), TRUE)
  testthat::expect_named(el)
  testthat::expect_true("sender" %in% names(el))
  testthat::expect_true("receiver" %in% names(el))
  testthat::expect_true("tweet_type" %in% names(el))
  testthat::expect_false("id_str" %in% names(el))
  testthat::expect_false("user_id_str" %in% names(el))
  testthat::expect_false("screen_name" %in% names(el))
  testthat::expect_true("gsa_aect" %in% el$sender)
  testthat::expect_false("AECT" %in% el$receiver)
  testthat::expect_true("RoutledgeEd" %in% el$receiver)
  testthat::expect_false("reply" %in% el$tweet_type)
  testthat::expect_true("retweet" %in% el$tweet_type)
  testthat::expect_false("quote" %in% el$tweet_type)
})



test_that("tweets build into edgelist with quote tweets", {

  el <- create_edgelist(processed_data, type = "quote")

  testthat::expect_equal(is.data.frame(el), TRUE)
  testthat::expect_named(el)
  testthat::expect_true("sender" %in% names(el))
  testthat::expect_true("receiver" %in% names(el))
  testthat::expect_true("tweet_type" %in% names(el))
  testthat::expect_false("id_str" %in% names(el))
  testthat::expect_false("user_id_str" %in% names(el))
  testthat::expect_false("screen_name" %in% names(el))
  testthat::expect_false("gsa_aect" %in% el$sender)
  testthat::expect_true("AECT" %in% el$receiver)
  testthat::expect_false("RoutledgeEd" %in% el$receiver)
  testthat::expect_false("reply" %in% el$tweet_type)
  testthat::expect_false("retweet" %in% el$tweet_type)
  testthat::expect_true("quote" %in% el$tweet_type)
})
