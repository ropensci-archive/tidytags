# library(tidyverse)
# library(rtweet)
# library(beepr)
#
# f <- "replace-with-path-to-file"
#
# d <- read_csv(f)
#
# d$id_str <- str_split(d$status_url, "/") %>%
#   map_chr(~.[6])
#
# lookup_many_tweets <- function(d) {
#   n_iterations <- d %>% pull(id_str) %>% length() %>% `/`(., 90000) %>% ceiling()
#
#   tags_rtweet <- data.frame()
#
#   for(i in 1:n_iterations) {
#     min = 90000*i - 89999; max = 90000*i
#
#     tags_rtweet <- d[min:max, ]$id_str %>%
#       lookup_tweets() %>%
#       flatten() %>%
#       rbind(tags_rtweet)
#
#     beepr::beep(2)
#     message("Processed iteration:", i)
#     if (i != n_iterations) {
#       message("Now sleeping...")
#       Sys.sleep(1200)
#       message("Awoke!")
#     }
#   }
#
#   tags_rtweet
# }
#
# dd <- lookup_many_tweets(tags)
