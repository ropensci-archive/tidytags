#' Retrieve user information for everyone in an edgelist
#'
#' Updates an edgelist created with `create_edgelist()` by appending user
#'   data retrieved with `rtweet::lookup_users()`. The resulting dataframe
#'   adds many additional columns and appends "_sender" or "_receiver" to the
#'   column names.
#' @param edgelist An edgelist of senders and receivers, such as that returned
#'   by the function `create_edgelist()`.
#' @return A dataframe in the form of an edgelist (i.e., with senders and
#'   receivers) as well as numerous, appropriately named columns of details
#'   about the senders and receivers.
#' @details This function requires authentication; please see
#'   `vignette("setup", package = "tidytags")`
#' @seealso Read more about rtweet authentication setup at
#'   `vignette("auth", package = "rtweet")`
#' @examples
#'
#' \donttest{
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tags_content <- read_tags(example_url)
#'
#' if (rtweet::auth_has_default()) {
#'   tweets_data <- lookup_many_tweets(tags_content)
#'   add_users_data(create_edgelist(tweets_data))
#' }
#' }
#'
#' @importFrom rlang .data
#' @export
add_users_data <-
  function(edgelist) {
    all_users <- unique(c(edgelist$sender, edgelist$receiver))
    users_data <- rtweet::lookup_users(all_users)

    senders_data <-
      dplyr::filter(users_data, .data$screen_name %in% edgelist$sender)
    names(senders_data) <- stringr::str_c("sender_", names(senders_data))
    names(senders_data)[4] <- "sender"

    receivers_data <-
      dplyr::filter(users_data, .data$screen_name %in% edgelist$receiver)
    names(receivers_data) <- stringr::str_c("receiver_", names(receivers_data))
    names(receivers_data)[4] <- "receiver"

    edgelist_with_senders_data <-
      dplyr::left_join(
        edgelist,
        senders_data,
        by = "sender"
      )

    edgelist_with_all_users_data <-
      dplyr::left_join(
        edgelist_with_senders_data,
        receivers_data,
        by = "receiver"
      )

    edgelist_with_all_users_data
  }
