context("Geocode TAGS data")
library(tidytags)

test_that("geo coordinates are extracted properly", {
  skip_on_covr()
  skip_on_cran()

  sample_locations <-
    tibble::tibble(
      screen_name = c("aect101", "aect102", "aect103", "aect104"),
      location = c("New York, NY", "Kansas", "#TheGreatOutdoors", "")
    )

  sample_locations_geocoded <- geocode_tags(sample_locations)

  expect_equal(round(sample_locations_geocoded$latitude[1], 3), 40.713)
  expect_equal(round(sample_locations_geocoded$latitude[2], 3), 38.273)
  expect_equal(round(sample_locations_geocoded$longitude[1], 3), -74.006)
  expect_equal(round(sample_locations_geocoded$longitude[2], 3), -98.582)
})


test_that("invalid geo coordinates produce warning", {
  skip_on_covr()
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
