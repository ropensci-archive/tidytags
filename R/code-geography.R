#' Retrieve geographic coordinates
#'
#' \code{geocode_tags()} retrieves geographic coordinates (i.e., latitude and
#'   longitude) based on the locations listed in Twitter user profiles.
#' @param df A dataframe or tibble
#' @param google_key A Google Developers API key which will need to be obtained
#'   by the user
#' @return Geographic coordinates (i.e., latitude and longitude) which may then be
#'   used to plot locations on a map
#' @seealso A key starting place is Google's
#'   \href{https://developers.google.com/maps/documentation/geocoding/intro}{
#'   geocoding documentation} for developers. This webpage describes the process
#'   of obtaining a Google Developers API key. Blog posts from
#'   \href{https://www.jessesadler.com/post/geocoding-with-r/}{Jesse Sadler}
#'   and \href{https://www.littlemissdata.com/blog/maps}{Laura Ellis}
#'   may also provide additional inspiration for geocoding. Finally, the
#'   \code{ggmap} package can provide additional functionality for visualizing
#'   geographic data.
geocode_tags <- function(df, google_key=Sys.getenv('Google_API_key')) {
  geo_coordinates <- mapsapi::mp_geocode(df$location, key=google_key)
  geo_points <- mapsapi::mp_get_points(geo_coordinates)
  geo_points
}
