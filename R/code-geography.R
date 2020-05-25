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
#' @examples
#'   \dontrun{
#'   example_url <- "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/edit#gid=8743918"
#'   tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#'   tmp_processed <- process_tweets(tmp_df)
#'   tmp_geo_coords <- geocode_tags(tmp_processed)
#'   tmp_geo_coords
#'   mapview::mapview(tmp_geo_coords$pnt)
#'   }
#' @export
geocode_tags <-
  function(df, google_key=Sys.getenv('Google_API_key')) {
    location_index <- which(df$location != "")
    locations_minus_blank <- df$location[location_index]
    geo_coordinates <- mapsapi::mp_geocode(locations_minus_blank, key = google_key)
    geo_points <- mapsapi::mp_get_points(geo_coordinates)
    geo_points
  }
