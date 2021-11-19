test_that("pull_tweet_data() is able to retrieve additional metadata starting
          with dataframe", {

  vcr::use_cassette("sample_tags2", {
    sample_tags <- read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
  })

  vcr::use_cassette("metadata_from_df", {
    from_df <- pull_tweet_data(sample_tags, n = 10)
  })

  expect_equal(is.data.frame(from_df), TRUE)
  expect_named(from_df)
  expect_true("user_id" %in% names(from_df))
  expect_true("status_id" %in% names(from_df))
  expect_true("status_url" %in% names(from_df))
  expect_true("reply_to_status_id" %in% names(from_df))
  expect_gt(ncol(from_df), ncol(sample_tags))
})



test_that("pull_tweet_data() is able to retrieve additional metadata starting
          with tweet IDs", {

  vcr::use_cassette("sample_tags2", {
    sample_tags <- read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
  })

  vcr::use_cassette("metadata_from_ids", {
    from_ids <- pull_tweet_data(id_vector = sample_tags$id_str, n = 10)
  })

  expect_equal(is.data.frame(from_ids), TRUE)
  expect_named(from_ids)
  expect_true("user_id" %in% names(from_ids))
  expect_true("status_id" %in% names(from_ids))
  expect_true("status_url" %in% names(from_ids))
  expect_true("reply_to_status_id" %in% names(from_ids))
  expect_gt(ncol(from_ids), ncol(sample_tags))
})



test_that("pull_tweet_data() is able to retrieve additional metadata starting
          with tweet URLs", {

  vcr::use_cassette("sample_tags2", {
    sample_tags <- read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
  })

  vcr::use_cassette("metadata_from_urls", {
    from_urls <- pull_tweet_data(url_vector = sample_tags$status_url, n = 10)
  })

  vcr::use_cassette("metadata_from_ids", {
    from_ids <- pull_tweet_data(id_vector = sample_tags$id_str, n = 10)
  })

  expect_true(is.data.frame(from_urls))
  expect_named(from_urls)
  expect_true("user_id" %in% names(from_urls))
  expect_true("status_id" %in% names(from_urls))
  expect_true("status_url" %in% names(from_urls))
  expect_true("reply_to_status_id" %in% names(from_urls))
  expect_gt(ncol(from_urls), ncol(sample_tags))
})
