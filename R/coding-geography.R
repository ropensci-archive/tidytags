## Read more here: https://developers.google.com/maps/documentation/geocoding/intro
## Learn how to get a Google Geocoding API Key here:
## https://developers.google.com/maps/documentation/geocoding/get-api-key
## See ?register_google

geocode <- function(df, api_key = Google_API_key) {
  mapsapi::mp_geocode(df$location, key = api_key) %>%
    mapsapi::mp_get_points()
   }

example_full$location
geocode(example_full)


## library(ggmap)
## https://www.jessesadler.com/post/geocoding-with-r/
locations_df <- ggmap::mutate_geocode(example_full, location)
locations_sf <- sd::st_as_sf(locations, coords = c("lon", "lat"), crs = 4326)
mapview::mapview(locations_sf)



