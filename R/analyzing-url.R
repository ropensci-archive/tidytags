library(tidyverse)
library(longurl)
library(urltools)

find_domain <- function(x) {
  expand_urls(x) %>%
    pull(expanded_url) %>%
    domain() %>%
    gsub("www[0-9]?.", "", .)
}

#find_domain("bit.ly/2SfWO3K")
