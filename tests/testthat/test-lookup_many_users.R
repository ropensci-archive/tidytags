test_that("lookup_many_users() works like rtweet::lookup_users()", {

  vcr::use_cassette("lookup_many_users", {
    example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
    sample_df <- pull_tweet_data(read_tags(example_url), n = 10)
    pull_regular <- rtweet::lookup_users(sample_df$screen_name)
    pull_many <- lookup_many_users(sample_df$screen_name)
  })

  expect_true(is.data.frame(pull_many))
  expect_named(pull_many)
  expect_true("user_id" %in% names(pull_many))
  expect_true("status_id" %in% names(pull_many))
  expect_true("status_url" %in% names(pull_many))
  expect_true("reply_to_status_id" %in% names(pull_many))
  expect_lte(nrow(pull_many), nrow(sample_df))
  expect_equal(ncol(pull_many), ncol(sample_df))
  expect_equal(ncol(pull_many), ncol(pull_regular))
  expect_equal(pull_many$user_id, pull_regular$user_id)
  expect_equal(pull_many$status_id, pull_regular$status_id)
})
