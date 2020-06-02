context("Geocode TAGS data")
library(tidytags)

test_that("geo coordinates are extracted properly", {
  skip_on_travis()
  skip_on_cran()

  sample_locations <-
    tibble::tibble(
      screen_name = c("aect101", "aect102", "aect103", "aect104"),
      location = c("New York, NY", "Kansas", "#TheGreatOutdoors", "")
    )

  expect_equal(round(geocode_tags(sample_locations)[[1]][1], 3), -74.006)
  expect_equal(round(geocode_tags(sample_locations)[[1]][2], 3), 40.713)
  expect_equal(round(geocode_tags(sample_locations)[[2]][1], 3), -98.484)
  expect_equal(round(geocode_tags(sample_locations)[[2]][2], 3), 39.012)
})


test_that("invalid geo coordinates produce warning", {
  skip_on_travis()
  skip_on_cran()

  sample_locations <-
    tibble::tibble(
      screen_name = c("aect101", "aect102", "aect103", "aect104"),
      location = c("New York, NY", "Kansas", "#TheGreatOutdoors", "")
    )

  expect_error(geocode_tags(sample_locations[3, ]))
  expect_error(geocode_tags(sample_locations[4, ]))
  expect_error(geocode_tags(sample_locations[3:4, ]))
})
