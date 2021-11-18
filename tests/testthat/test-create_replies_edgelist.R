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


test_that("replies are identified", {

  replies <- create_replies_edgelist(sample_data)

  expect_true(is.data.frame(replies))
  expect_named(replies)
  expect_true("sender" %in% names(replies))
  expect_true("receiver" %in% names(replies))
  expect_true("edge_type" %in% names(replies))
})
