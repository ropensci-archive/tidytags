#' Retrieve user information for everyone in an edgelist
#'
#' Updates an edgelist created with \code{create_edgelist()} by appending user
#'   data retrieved with \code{rtweet::lookup_users()}. The resulting dataframe
#'   keeps all the columns from \code{rtweet} but adds "_sender" or "_receiver"
#'   to the column names.
#' @param edgelist An edgelist of senders and receivers, such as that returned
#'   by the function \code{create_edgelist()}.
#' @return A dataframe in the form of an edgelist (i.e., with senders and
#'   receivers) as well as numerous, appropriately named columns of details
#'   about the senders and receivers.
#' @details This function requires authentication; please see
#'   \code{vignette("setup", package = "tidytags")}
#' @seealso Review documentation for \code{rtweet::lookup_users()} for a full
#'   list of metadata retrieved (i.e., column names) by this function.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url))
#' add_users_data(create_edgelist(tmp_df))
#' }
#' @importFrom rlang .data
#' @export
add_users_data <-
  function(edgelist) {
    all_users <- unique(c(edgelist$sender, edgelist$receiver))
    users_data_from_rtweet <- rtweet::lookup_users(all_users)

    users_prepped <-
      dplyr::select(
        users_data_from_rtweet,
        .data$screen_name,
        tidyselect::everything()
      )

    senders_prepped <-
      dplyr::rename(
        users_prepped,
        sender = .data$screen_name
      )

    names(senders_prepped)[2:length(senders_prepped)] <-
      stringr::str_c(names(senders_prepped),
                     "_sender")[2:length(senders_prepped)]

    receivers_prepped <-
      dplyr::rename(
        users_prepped,
        receiver = .data$screen_name
      )

    names(receivers_prepped)[2:length(receivers_prepped)] <-
      stringr::str_c(names(receivers_prepped),
                     "_receiver")[2:length(receivers_prepped)]

    edgelist_with_senders_data <-
      dplyr::left_join(
        edgelist,
        senders_prepped,
        by = "sender"
      )

    edgelist_with_all_users_data <-
      dplyr::left_join(
        edgelist_with_senders_data,
        receivers_prepped,
        by = "receiver"
      )

    edgelist_with_all_users_data
  }
