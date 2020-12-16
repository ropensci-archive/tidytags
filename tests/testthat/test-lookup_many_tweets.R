test_that("lookup_many_tweets() retrieves additional metadata like pull_tweet_data()", {

  vcr::use_cassette("lookup_many", {
    sample_tags <- read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
    pull_regular <- pull_tweet_data(sample_tags, n = 10)
    pull_many <- lookup_many_tweets(sample_tags$id_str[1:10])
  })

  expect_true(is.data.frame(pull_many))
  expect_named(pull_many)
  expect_true("user_id" %in% names(pull_many))
  expect_true("status_id" %in% names(pull_many))
  expect_true("status_url" %in% names(pull_many))
  expect_true("reply_to_status_id" %in% names(pull_many))
  expect_gt(ncol(pull_many), ncol(sample_tags))
  expect_equal(ncol(pull_many), ncol(pull_regular))
  expect_equal(pull_many$user_id, pull_regular$user_id)
  expect_equal(pull_many$status_id, pull_regular$status_id)
})
