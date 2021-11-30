status_id <- c("aaa", "bbb", "ccc", "ddd", "eee")
reply_to_status_id <- c("bbb", NA, NA, "fff", NA)

df1 <- data.frame(status_id, reply_to_status_id)
df2 <- data.frame(status_id, reply_to_status_id = rep(NA, 5))
df3 <- data.frame(x = status_id, reply_to_status_id)
df4 <- data.frame(status_id, y = rep(NA, 5))

test_that("function returns dataframe of expected length", {
  expect_equal(nrow(flag_unknown_upstream(df1)), 1)
  expect_equal(nrow(flag_unknown_upstream(df2)), 0)
  expect_equal(nrow(flag_unknown_upstream(df3)), 2)
  expect_error(flag_unknown_upstream(df4))
})
