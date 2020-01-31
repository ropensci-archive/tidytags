add_users_data <- function(edgelist, users){

  # proc users

  users_ss <- users %>%
    mutate(screen_name = tolower(screen_name)) %>%
    select(screen_name, everything()) %>%
    distinct(screen_name, .keep_all = TRUE)

  # for senders

  ds_edge_sender <- edgelist %>%
    mutate(screen_name = tolower(sender))

  names(users_ss)[2:length(users_ss)] <-
    str_c(names(users_ss), "_sender")[2:length(users_ss)] # this makes the names of all sender vars have sender in them

  d <- left_join(ds_edge_sender, users_ss, by = "screen_name")

  # for receivers

  ds_edge_receiver <- d %>%
    mutate(sender = screen_name, # changing the name of screen_name back to sender
           screen_name = tolower(receiver))

  users_ss <- users %>% # would be nice to not have to do this again!
    # it is because of the names issue - an easy fix
    mutate(screen_name = tolower(screen_name)) %>%
    select(screen_name, everything()) %>%
    distinct(screen_name, .keep_all = TRUE)

  names(users_ss)[2:length(users_ss)] <-
    str_c(names(users_ss), "_receiver")[2:length(users_ss)]

  left_join(ds_edge_receiver, users_ss, by = "screen_name") %>%
    select(-screen_name)
}
