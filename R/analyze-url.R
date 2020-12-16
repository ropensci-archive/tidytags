#' Find the domain name of URLs, even shortened URLs
#'
#' \code{get_url_domain()} retrieves the Web domain name from a URL, including
#'   URLs shortened with services such as bit.ly and t.co
#' @param x A list or vector of hyperlinks, whether shortened or expanded
#' @param wait How long (in seconds) to wait on the \code{longurl::expand_urls()}
#'   function to retrieve the full, expanded URL from a shortened URL (e.g., a bit.ly).
#'   The \code{longurl} default is 2 seconds, but we have found that this misses
#'   a number of valid URLs. Here, we have made the default \code{wait = 10} seconds,
#'   but the user can adjust this as they like.
#' @return A list or vector of Web domain names
#' @seealso Read the documentation for \code{longurl::expand_urls()} and
#'   \code{urltools::domain()}.
#' @examples
#'
#' \dontrun{
#'
#' get_url_domain("https://www.tidyverse.org/packages/")
#' get_url_domain("https://dplyr.tidyverse.org/")
#' get_url_domain("http://bit.ly/2SfWO3K")
#' }
#' @export
get_url_domain <-
  function(x, wait = 10) {
    new_urls <- suppressWarnings(longurl::expand_urls(x, seconds = wait))
    domains <- urltools::domain(new_urls$expanded_url)
    domains <- gsub("www[0-9]?.", "", domains)
    domains
  }
