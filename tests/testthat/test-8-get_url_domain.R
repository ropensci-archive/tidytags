test_that("get_url_domain() works on a variety of domains", {

  vcr::use_cassette("url_domains", {
    domain1 <- get_url_domain("https://www.tidyverse.org/")
    domain2 <- get_url_domain("https://www.tidyverse.org/packages/")
    domain3 <- get_url_domain("https://dplyr.tidyverse.org/")
    domain4 <- get_url_domain("https://www.npr.org/sections/technology/")
  })

  testthat::expect_equal(domain1, "tidyverse.org")
  testthat::expect_equal(domain2, "tidyverse.org")
  testthat::expect_equal(domain3, "dplyr.tidyverse.org")
  testthat::expect_equal(domain4, "npr.org")
})
