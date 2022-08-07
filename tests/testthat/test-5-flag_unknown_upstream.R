id_str <- c("aaa", "bbb", "ccc", "ddd", "eee")
in_reply_to_status_id_str <- c("bbb", NA, NA, "fff", NA)

df1 <- data.frame(id_str, in_reply_to_status_id_str)
df2 <- data.frame(id_str, in_reply_to_status_id_str = rep(NA, 5))
df3 <- data.frame(x = id_str, in_reply_to_status_id_str)
df4 <- data.frame(id_str, y = rep(NA, 5))

test_that("function returns dataframe of expected length", {
  testthat::expect_equal(nrow(flag_unknown_upstream(df1)), 1)
  testthat::expect_equal(nrow(flag_unknown_upstream(df2)), 0)
  testthat::expect_equal(nrow(flag_unknown_upstream(df3)), 2)
  testthat::expect_error(flag_unknown_upstream(df4))
})
