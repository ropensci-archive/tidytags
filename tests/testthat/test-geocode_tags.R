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
  expect_equal(round(locations_coords$latitude[2], 1), 38.3)
  expect_equal(round(locations_coords$longitude[1], 1), -74.0)
  expect_equal(round(locations_coords$longitude[2], 1), -98.6)
})


test_that("invalid geo coordinates produce warning", {
  locations_fake <-
    tibble::tibble(
      screen_name = c("aect104", "aect105"),
      location = c("", NA)
    )

  vcr::use_cassette("geo_coords_error", {
    expect_error(geocode_tags(locations_fake), "There are no valid geolocations to report.")
    expect_error(geocode_tags(locations_fake[1, ]))
    expect_error(geocode_tags(locations_fake[2, ]))
  })

})
