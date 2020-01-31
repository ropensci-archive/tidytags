## Read more here: https://developers.google.com/maps/documentation/geocoding/intro

geocode_tags <- function(df, google_key=Sys.getenv('Google_API_key')) {
  geo_coordinates <- mapsapi::mp_geocode(df$location, key=google_key)
  geo_points <- mapsapi::mp_get_points(geo_coordinates)
  geo_points
}

## Additional resources for geocoding:
## https://www.jessesadler.com/post/geocoding-with-r/
## https://www.littlemissdata.com/blog/maps
## library(ggmap); ggmap::get_googlemap()
