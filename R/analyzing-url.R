get_url_domain <- function(x) {
  new_urls <- longurl::expand_urls(x, seconds=10)
  domains <- urltools::domain(new_urls$expanded_url)
  domains <- gsub("www[0-9]?.", "", domains)
  domains
}
