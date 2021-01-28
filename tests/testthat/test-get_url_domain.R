test_that("get_url_domain() works on a variety of domains", {

  vcr::use_cassette("url_domains", {
    domain1 <- get_url_domain("https://www.tidyverse.org/")
    domain2 <- get_url_domain("https://www.tidyverse.org/packages/")
    domain3 <- get_url_domain("https://dplyr.tidyverse.org/")
    domain4 <- get_url_domain("https://www.npr.org/sections/technology/")
    url1 <- longurl::expand_urls("http://bit.ly/2SfWO3K", seconds=10)$expanded_url
  })

    expect_equal(domain1, "tidyverse.org")
    expect_equal(domain2, "tidyverse.org")
    expect_equal(domain3, "dplyr.tidyverse.org")
    expect_equal(domain4, "npr.org")
})


test_that("get_url_domain() works on shortened URLs", {

  vcr::use_cassette("url_short_domains", {
    domain5 <- get_url_domain("http://bit.ly/2SfWO3K")
    domain6 <- get_url_domain("http://bit.ly/36KWct1")
  })

  skip(message = "Skipping bit.ly examples for now.")
  expect_equal(domain5, "aect.org")
  expect_equal(domain6, "aera.net")
})

test_that("longurl::expand_urls() works for vcr", {

  vcr::use_cassette("longurl_test", {
    url1 <- longurl::expand_urls("http://bit.ly/2SfWO3K", seconds=10)$expanded_url
  })

  skip(message = "Skipping longurltest for now.")
  expect_equal(url1, "https://www.aect.org/about_us.php")
})
