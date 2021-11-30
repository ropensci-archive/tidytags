sample_list0 <- list(NA)
sample_list1 <- list("a")
sample_list2 <- list(c("a", "b"))
sample_list3 <- list(c("a", "b", NA))

test_that("NA value is length 0", {
  expect_equal(length_with_na(sample_list0), 0)
})

test_that("list with several values is expected length", {
  expect_equal(length_with_na(sample_list1), 1)
  expect_equal(length_with_na(sample_list2), 2)
  expect_equal(length_with_na(sample_list3), 3)
})
