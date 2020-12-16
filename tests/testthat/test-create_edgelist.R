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


test_that("tweets build into edgelist", {

  el <- create_edgelist(sample_data)

  expect_true(is.data.frame(el))
  expect_named(el)
  expect_true("sender" %in% names(el))
  expect_true("receiver" %in% names(el))
  expect_true("edge_type" %in% names(el))
  expect_true("gsa_aect" %in% el$sender)
  expect_true("AECT" %in% el$receiver)
  expect_true("retweet" %in% el$edge_type)
})
