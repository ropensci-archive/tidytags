library(mapsapi)

geocode <- function(d, key = maps_api_key) {
  mp_geocode(d$location, key = key) %>%
    mp_get_points()
}
