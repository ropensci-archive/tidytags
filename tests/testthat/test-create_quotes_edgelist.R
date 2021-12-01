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


test_that("quote tweets are identified", {

  quotes <- create_quotes_edgelist(sample_data)

  expect_true(is.data.frame(quotes))
  expect_named(quotes)
  expect_true("sender" %in% names(quotes))
  expect_true("receiver" %in% names(quotes))
  expect_true("edge_type" %in% names(quotes))
})
