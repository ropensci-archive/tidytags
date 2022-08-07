sample_data <-
  readr::read_csv("sample-data.csv", col_names = TRUE)

sample_tweet <-
  readr::read_csv("sample-tweet.csv", col_names = TRUE)


test_that("get_char_tweet_ids() extracts correct ID number", {
  testthat::expect_equal(get_char_tweet_ids(sample_tweet),
               "1219758386436165633")
  testthat::expect_equal(get_char_tweet_ids(sample_tweet$status_url),
               "1219758386436165633")
  testthat::expect_equal(get_char_tweet_ids(sample_data[8, ]),
               "1225122317849657345")
  testthat::expect_equal(get_char_tweet_ids(sample_data$status_url[8]),
               "1225122317849657345")
})
