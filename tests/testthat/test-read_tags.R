test_that("a TAGS tweet tracker is imported properly from Google Sheets", {

  vcr::use_cassette("sample_tags", {
    example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
    sample_tags <- head(read_tags(example_url), 10)
  })

  expect_true(is.data.frame(sample_tags))
  expect_named(sample_tags)
  expect_true("id_str" %in% names(sample_tags))
  expect_true("from_user" %in% names(sample_tags))
  expect_true("status_url" %in% names(sample_tags))
  expect_gt(ncol(sample_tags), 15)
})
