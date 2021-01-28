test_that("get_url_domain() works on a variety of domains and shortened URLs", {

  vcr::use_cassette("url_domains", {
    domain1 <- get_url_domain("https://www.tidyverse.org/")
    domain2 <- get_url_domain("https://www.tidyverse.org/packages/")
    domain3 <- get_url_domain("https://dplyr.tidyverse.org/")
    domain4 <- get_url_domain("http://bit.ly/2SfWO3K")
    domain5 <- get_url_domain("http://bit.ly/36KWct1")
    domain6 <- get_url_domain("https://www.npr.org/")
  })

    expect_equal(domain1, "tidyverse.org")
    expect_equal(domain2, "tidyverse.org")
    expect_equal(domain3, "dplyr.tidyverse.org")
    expect_equal(domain6, "npr.org")
    skip(message = "Skipping bit.ly examples for now.")
    expect_equal(domain4, "aect.org")
    expect_equal(domain5, "aera.net")

})
