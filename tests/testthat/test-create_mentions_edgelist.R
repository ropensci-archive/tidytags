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


test_that("mentions are identified", {

  mentions <- create_mentions_edgelist(sample_data)

  expect_true(is.data.frame(mentions))
  expect_named(mentions)
  expect_true("sender" %in% names(mentions))
  expect_true("receiver" %in% names(mentions))
  expect_true("edge_type" %in% names(mentions))
})
