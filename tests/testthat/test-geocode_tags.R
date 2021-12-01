test_that("geo coordinates are extracted properly", {
  locations_real <-
    tibble::tibble(
      screen_name = c("aect101", "aect102", "aect103", "aect104", "aect105"),
      location = c("New York, NY", "Kansas", "#TheGreatOutdoors", "", NA)
    )

    vcr::use_cassette("geo_coords", {
      locations_coords <- geocode_tags(locations_real)
    })

  expect_equal(round(locations_coords$latitude[1], 1), 40.7)
  expect_equal(round(locations_coords$longitude[1], 1), -74.0)
  expect_equal(round(locations_coords$latitude[2], 1), 38.3)
  expect_equal(round(locations_coords$longitude[2], 1), -98.6)
  expect_true(is.na(locations_coords$latitude[3]))
  expect_true(is.na(locations_coords$longitude[3]))
  expect_true(is.na(locations_coords$latitude[4]))
  expect_true(is.na(locations_coords$longitude[4]))
  expect_true(is.na(locations_coords$latitude[5]))
  expect_true(is.na(locations_coords$longitude[5]))
  expect_equal(locations_coords$location[1], "New York, NY")
  expect_equal(locations_coords$location[2], "Kansas")
  expect_equal(locations_coords$location[3], "#TheGreatOutdoors")
  expect_true(is.na(locations_coords$location[4]))
  expect_true(is.na(locations_coords$location[5]))
  expect_message()
})
