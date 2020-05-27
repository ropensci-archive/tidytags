#' Retrieve geographic coordinates
#'
#' \code{geocode_tags()} retrieves geographic coordinates (i.e., latitude and
#'   longitude) based on the locations listed in Twitter user profiles. \code{geocode_tags()}
#'   pulls from the Google Geocoding API, which requires a Google Geocoding API Key.
#'   You can easily secure a key through Google Cloud Platform;
#'   \href{https://developers.google.com/maps/documentation/geocoding/get-api-key}{read more here}.
#'   We recommend saving your Google Geocoding API Key in the \code{.Renviron} file as
#'   **Google_API_key**. You can quickly access this file using the R code
#'   \code{usethis::edit_r_environ(scope='user')}. Add a line to this file that reads:
#'   \code{Google_API_key="PasteYourGoogleKeyInsideTheseQuotes"}. To read your key into R,
#'   use the code \code{Sys.getenv('Google_API_key')}. Note that the \code{geocode_tags()}
#'   function retrieves your saved API key automatically and securely. Once you've
#'   saved the \code{.Renviron} file, quit your R session and restart. The function
#'   \code{geocode_tags()} will work for you from now on.
#' @param df A dataframe or tibble
#' @param google_key A Google Developers API key which will need to be obtained
#'   by the user
#' @return A vector of geographic coordinates (i.e., latitude and longitude) which may then be
#'   used to plot locations on a map
#' @seealso Blog posts from \href{https://www.jessesadler.com/post/geocoding-with-r/}{Jesse Sadler} and
#'   \href{https://www.littlemissdata.com/blog/maps}{Laura Ellis} may also provide additional inspiration for geocoding.
#'
#'   The **ggmap** package can provide additional functionality for visualizing
#'   geographic data.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8/edit#gid=8743918"
#' tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#' tmp_geo_coords <- geocode_tags(tmp_df)
#' tmp_geo_coords
#' tmp_geo_coords[[1]]
#' tmp_geo_coords[[1]][1]; tmp_geo_coords[[1]][2]
#' mapview::mapview(tmp_geo_coords)
#'
#' }
#' @export
geocode_tags <-
  function(df, google_key = Sys.getenv("Google_API_key")) {
    location_index <-
      which((df$location != "") & !(stringr::str_detect(df$location, "#")))
    locations_minus_blank <-
      df$location[location_index]
    if(length(locations_minus_blank) == 0) {
      stop("There are no valid geolocations to report.")
    }
    geo_coordinates <-
      mapsapi::mp_geocode(locations_minus_blank, key = google_key)
    geo_points <-
      mapsapi::mp_get_points(geo_coordinates)
    as.vector(geo_points$pnt)
  }
