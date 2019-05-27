add_users_data <- function(edgelist, users){

  # proc users

  users_ss <- users %>%
    mutate(screen_name = tolower(screen_name)) %>%
    select(screen_name, everything()) %>%
    distinct(screen_name, .keep_all = TRUE)

  # for senders

  ds_edge_send <- ds_edge %>%
    mutate(screen_name = tolower(sender))

  names(users_ss)[2:length(users_ss)] <-
    str_c(names(users_ss), "_sender")[2:length(users_ss)]

  d <- left_join(ds_edge_send, users_ss, by = "screen_name")

  # for receivers

  ds_edge_receiver <- ds_edge %>%
    mutate(screen_name = tolower(receiver))

  names(users_ss)[2:length(users_ss)] <-
    str_c(names(users_ss), "_receiver")[2:length(users_ss)]

  left_join(d, users_ss, by = "screen_name")

}
