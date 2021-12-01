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


test_that("retweets are identified", {

  retweets <- create_retweets_edgelist(sample_data)

  expect_true(is.data.frame(retweets))
  expect_named(retweets)
  expect_true("sender" %in% names(retweets))
  expect_true("receiver" %in% names(retweets))
  expect_true("edge_type" %in% names(retweets))
})

test_that("edgelist gets built even without any retweets", {

  retweets2 <- create_retweets_edgelist(head(sample_data, 1))

  expect_true(is.data.frame(retweets2))
  expect_named(retweets2)
  expect_true("sender" %in% names(retweets2))
  expect_true("receiver" %in% names(retweets2))
  expect_true("edge_type" %in% names(retweets2))
})
