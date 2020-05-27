context("Get URL domain")
library(tidytags)

test_that("get_url_domain() works on a variety of domains and shortened URLs", {
  expect_equal(get_url_domain("https://www.tidyverse.org/"), "tidyverse.org")
  expect_equal(get_url_domain("https://www.tidyverse.org/packages/"), "tidyverse.org")
  expect_equal(get_url_domain("https://dplyr.tidyverse.org/"), "dplyr.tidyverse.org")
  expect_equal(get_url_domain("http://bit.ly/2SfWO3K"), "aect.org")
})
