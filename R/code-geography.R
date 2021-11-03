#' Retrieve geographic coordinates
#'
#' \code{geocode_tags()} retrieves geographic coordinates (i.e., latitude and
#'   longitude) based on the locations listed in Twitter user profiles.
#'   \code{geocode_tags()} pulls from the OpenCage Geocoding API, which requires
#'   a OpenCage Geocoding API Key. You can easily secure a key through OpenCage;
#'   \href{https://opencagedata.com/api#quickstart}{read more here}. We
#'   recommend saving your OpenCage Geocoding API Key in the \code{.Renviron}
#'   file as **OPENCAGE_KEY**. You can quickly access this file using the R code
#'   \code{usethis::edit_r_environ(scope='user')}. Add a line to this file that
#'   reads: \code{OPENCAGE_KEY="PasteYourOpenCageKeyInsideTheseQuotes"}. To read
#'   your key into R, use the code \code{Sys.getenv('OPENCAGE_KEY')}. Note that
#'   the \code{geocode_tags()} function retrieves your saved API key
#'   automatically and securely. Once you've saved the \code{.Renviron} file,
#'   quit your R session and restart. The function \code{geocode_tags()} will
#'   work for you from now on.
#' @param df A dataframe or tibble
#' @return A tibble of geographic coordinates (i.e., latitude and longitude)
#'   that can then be used to plot locations on a map
#' @seealso \href{https://opencagedata.com/api}{OpenCage Geocoding API
#'   Documentation}
#'
#'   Blog posts from
#'   \href{https://www.jessesadler.com/post/geocoding-with-r/}{Jesse Sadler} and
#'   \href{https://www.littlemissdata.com/blog/maps}{Laura Ellis} may also
#'   provide additional inspiration for geocoding.
#'
#'   The **ggmap** package can provide additional functionality for visualizing
#'   geographic data.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#' tmp_geo_coords <- geocode_tags(tmp_df)
#' tmp_geo_coords
#' locations <- sf::st_as_sf(
#'   tmp_geo_coords,
#'   coords = c(x = "longitude", y = "latitude"),
#'   crs = 4326)
#' mapview::mapview(locations)
#' }
#' @export
geocode_tags <-
  function(df) {

    df_cleaned <-
      dplyr::filter(
        df,
        .data$location != "",
        !is.na(.data$location)
      )

    if (nrow(df_cleaned) == 0) {
      stop("There are no valid geolocations to report.")
    }

    df_lat_lon <-
      suppressMessages(opencage::oc_forward_df(df_cleaned,
                                               placename = .data$location,
                                               bind_cols = TRUE))

    df_final <-
      dplyr::rename(df_lat_lon,
                    latitude = .data$oc_lat,
                    longitude = .data$oc_lng,
                    formatted = .data$oc_formatted)

    df_final
  }
