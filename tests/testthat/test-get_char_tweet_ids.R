sample_data <-
  readr::read_csv("sample-data.csv",
    col_names = TRUE,
    col_types = readr::cols(
      user_id = readr::col_character(),
      status_id = readr::col_character(),
      retweet_status_id = readr::col_character(),
      quoted_status_id = readr::col_character(),
      reply_to_status_id = readr::col_character()
    )
  )

sample_tweet <-
  readr::read_csv("sample-tweet.csv",
    col_names = TRUE,
    col_types = readr::cols(
      user_id = readr::col_character(),
      status_id = readr::col_character(),
      retweet_status_id = readr::col_character(),
      quoted_status_id = readr::col_character(),
      reply_to_status_id = readr::col_character()
    )
  )


test_that("get_char_tweet_ids() extracts correct ID number", {
  expect_equal(get_char_tweet_ids(sample_tweet),
               "1219758386436165633")
  expect_equal(get_char_tweet_ids(sample_tweet$status_url),
               "1219758386436165633")
  expect_equal(get_char_tweet_ids(sample_data[8, ]),
               "1225137879921385472")
  expect_equal(get_char_tweet_ids(sample_data$status_url[8]),
               "1225137879921385472")
})
