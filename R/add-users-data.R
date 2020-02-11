#' Retrieve user information for everyone in an edgelist
#'
#' \code{add_users_data()} updates an edgelist created with \code{create_edgelist()}
#'   by appending user data retrieved with \code{rtweet::users_data()}. The resulting
#'   dataframe keeps all the columns from \code{rtweet} but adds "_sender" or
#'   "_receiver" to the column names
#' @param edgelist An edgelist of senders and receivers, such as that returned by
#'   the function \code{create_edgelist()}.
#' @param users_data_from_rtweet A dataframe with Twitter users data retrieved using
#'   the function \code{rtweet::users_data()}.
#' @return A dataframe in the form of an edgelist (i.e., with senders and receivers)
#'   as well as numerous, appropriately named columns of details about the senders
#'   and receivers.
#' @seealso Review documentation for \code{rtweet::users_data()} for a full list
#'   of metadat retrieved (i.e., column names) by this function.
#' @export
add_users_data <- function(edgelist, users_data_from_rtweet){
  users_prepped <- dplyr::mutate(users_data_from_rtweet,
                                 screen_name = tolower(screen_name)
                                 )
  users_prepped <- dplyr::select(users_prepped,
                                 screen_name,
                                 tidyselect::everything()
                                 )
  users_prepped <- dplyr::distinct(users_prepped,
                                   screen_name, .keep_all = TRUE)
  senders_prepped <- dplyr::mutate(edgelist,
                                   screen_name = tolower(sender)
                                   )

  ## edit all sender variable names to have "_sender" in them
  names(users_prepped)[2:length(users_prepped)] <-
    stringr::str_c(names(users_prepped), "_sender")[2:length(users_prepped)]
  edgelist_with_senders_data <- dplyr::left_join(senders_prepped,
                                                 users_prepped,
                                                 by = "screen_name")

  ## change the name of screen_name back to sender
  receivers_prepped <- dplyr::mutate(edgelist_with_senders_data,
                                     sender = screen_name,
                                     screen_name = tolower(receiver)
                                     )

  ## would be nice to not have to do this again! (it is because of the names issue - an easy fix)
  users_prepped <- dplyr::mutate(users_data_from_rtweet,
                                 screen_name = tolower(screen_name)
                                 )
  users_prepped <- dplyr::select(users_prepped,
                                 screen_name,
                                 tidyselect::everything()
                                 )
  users_prepped <- dplyr::distinct(users_prepped,
                                   screen_name, .keep_all = TRUE)

  ## edit all sender variable names to have "_receiver" in them
  names(users_prepped)[2:length(users_prepped)] <-
    stringr::str_c(names(users_prepped), "_receiver")[2:length(users_prepped)]

  edgelist_with_all_users_data <- dplyr::left_join(receivers_prepped,
                                                   users_prepped,
                                                   by = "screen_name")
  edgelist_with_all_users_data <- dplyr::select(edgelist_with_all_users_data, -screen_name)
}
