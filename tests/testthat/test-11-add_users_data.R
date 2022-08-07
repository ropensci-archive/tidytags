vcr::use_cassette("sample_tags", {
  sample_tags <- read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
})

vcr::use_cassette("different_tweet_types", {
  app <- rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
  rtweet::auth_as(app)
  more_info <- pull_tweet_data(sample_tags, n = 100)
})

processed_data <- process_tweets(more_info)
el <- create_edgelist(processed_data)

vcr::use_cassette("users_info", {
  el_users <- add_users_data(el)
})

test_that("user data is added properly", {

  testthat::expect_equal(is.data.frame(el_users), TRUE)
  testthat::expect_named(el_users)
  testthat::expect_true("sender" %in% names(el_users))
  testthat::expect_true("receiver" %in% names(el_users))
  testthat::expect_true("tweet_type" %in% names(el_users))
  testthat::expect_false("id_str" %in% names(el_users))
  testthat::expect_true("sender_id_str" %in% names(el_users))
  testthat::expect_true("receiver_id_str" %in% names(el_users))
  testthat::expect_true("sender_location" %in% names(el_users))
  testthat::expect_true("receiver_location" %in% names(el_users))
  testthat::expect_true("sender_description" %in% names(el_users))
  testthat::expect_true("receiver_description" %in% names(el_users))
  testthat::expect_true("gsa_aect" %in% el_users$sender)
  testthat::expect_true("AECT" %in% el_users$receiver)
  testthat::expect_true("RoutledgeEd" %in% el_users$receiver)
  testthat::expect_true("reply" %in% el_users$tweet_type)
  testthat::expect_true("retweet" %in% el_users$tweet_type)
  testthat::expect_true("quote" %in% el_users$tweet_type)
  testthat::expect_gt(ncol(el_users), ncol(el))
  testthat::expect_equal(nrow(el_users), nrow(el))
  testthat::expect_equal(el_users$sender, el$sender)
  testthat::expect_equal(el_users$receiver, el$receiver)
})
