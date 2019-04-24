#
# profiles_gender <- read_csv("profiles-gender.csv",
#                             col_names = FALSE, skip = 1) %>%
#   rename(word = X1, gender = X2)
#
# users <- users_data(d) %>%
#   distinct()
#
# coded_users <- users %>%
#   tidytext::unnest_tokens(word, description) %>%
#   left_join(profiles_gender, by = "word") %>%
#   distinct(screen_name, gender, .keep_all = TRUE)
#
# coded_users %>% count(gender)
#
# joined_users <- users %>%
#   distinct(screen_name, name) %>%
#   left_join(coded_users) %>%
#   filter(!is.na(gender))
#
# unique_names <- users %>%
#   anti_join(joined_users, by = "screen_name") %>%
#   mutate(name_list = str_split(name, " ")) %>%
#   mutate(first_name = map_chr(name_list, ~ .[1]))
#
# gender_coded_names <- gender::gender(unique_names$first_name) %>%
#   select(name, gender) %>%
#   distinct()
#
# auto_coded_users <- unique_names %>%
#   select(-name_list, -name) %>%
#   rename(name = first_name) %>%
#   left_join(gender_coded_names, by = "name") %>%
#   distinct()
#
# a <- joined_users %>% count(gender) %>% mutate(method = 'self_id_n')
# b <- auto_coded_users %>% count(gender) %>% mutate(method = 'prediction_n')
#
# bind_rows(a, b) %>%
#   spread(method, n) %>%
#   mutate(prediction_prop = prediction_n/sum(prediction_n, na.rm = TRUE),
#          self_id_prop = self_id_n/sum(self_id_n, na.rm = TRUE))
#
# a %>% full_join(b, by = "gender") %>%
#   gather(key, val, -gender) %>%
#   group_by(gender) %>%
#   summarize(n = sum(val, na.rm = TRUE)) %>%
#   mutate(prop = n/sum(n)) %>%
#   arrange(desc(n))
#
# ddd <- bind_rows(joined_users, auto_coded_users)
# dddd <- distinct(ddd, screen_name, gender)
#
# da <- d %>% left_join(dddd)
#
# edgelist <- create_edgelist(d)
#
# edgelist %>%
#   rename(screen_name = sender) %>%
#   left_join(dddd) %>%
#   rename(sender_gender = gender) %>%
#   rename(sender = screen_name, screen_name = receiver) %>%
#   left_join(dddd)
# rename(receiver = screen_name, receiver_gender = gender)
#
# ddd %>% janitor::tabyl(gender)
#
# joined_users_d <- joined_users %>%
#   mutate(name_list = str_split(name, " ")) %>%
#   mutate(first_name = map_chr(name_list, ~ .[1]))
#
# x <- joined_users_d %>%
#   pull(first_name) %>%
#   gender::gender() %>%
#   rename(first_name = name, predicted_gender = gender) %>%
#   right_join(joined_users_d) %>%
#   distinct(screen_name, name, .keep_all = TRUE) %>%
#   janitor::tabyl(gender, predicted_gender)
#
# x %>%
#   mutate(female_sum = sum(female))
