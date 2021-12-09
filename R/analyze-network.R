#' Create an edgelist where interaction is defined by replying
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{create_edgelist()} processes the tweets by calling
#'   \code{process_tweets()} and filters the dataset to only keep the specific
#'   tweet types (e.g., replies, retweets, quote tweets, and mentions)
#'   requested. \code{filter_by_tweet_type()} is a useful function in itself,
#'   but it is also used in \code{create_edgelist()}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @param type The specific kind of tweets that will be kept in the dataset
#'   after filtering the rest. Choices for \code{type}include"reply", "retweet",
#'   "quote", or "mention." Defaults to "all."
#' @return A dataframe of processed tweets and fewer rows. Only the tweets of
#'   the specified type will remain.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url))
#' tmp_re <- filter_by_tweet_type(tmp_df, "reply")
#' tmp_rt <- filter_by_tweet_type(tmp_df, "retweet")
#' tmp_qu <- filter_by_tweet_type(tmp_df, "quote")
#' tmp_me <- filter_by_tweet_type(tmp_df, "mention")
#' }
#' @importFrom rlang .data
#' @export
filter_by_tweet_type <-
  function(df, type) {

    processed_df <- process_tweets(df)

    ifelse(type %in% c("reply", "retweet", "quote"),
           filtered_df <-
             dplyr::filter(processed_df,
                           !!as.symbol(paste0("is_", type)) == TRUE),
           ifelse(type == "mention",
                  filtered_df <-
                    dplyr::filter(processed_df,
                                  mentions_count > 0),
                  filtered_df <- processed_df
           )
    )

    filtered_df
  }


#' Create an edgelist where senders and receivers are defined by different types
#'   of Twitter interactions
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{create_edgelist()} processes the statuses by calling
#'   \code{process_tweets()}, filters the dataset to only keep the specific
#'   status types (e.g., replies, retweets, quote tweets, and mentions)
#'   requested by calling \code{filter_by_tweet_type()}, pulls out senders and
#'   receivers of the specified type of statuses, and then adds a new column.
#'   \code{edge_type}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @param type The specific kind of statuses used to define the interactions
#'   around which the edgelist will be built. Choices include"reply", "retweet",
#'   "quote", or "mention." Defaults to "all."
#' @return A dataframe edgelist defined by interactions through the type of
#'   statuses specified. The dataframe has three columns: \code{sender},
#'   \code{receiver}, and \code{edge_type}.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url))
#'
#' full_edgelist <- create_edgelist(tmp_df)
#' full_edgelist
#'
#' reply_edgelist <- create_edgelist(tmp_df, type = "reply")
#' retweet_edgelist <- create_edgelist(tmp_df, type = "retweet")
#' quote_edgelist <- create_edgelist(tmp_df, type = "quote")
#' mention_edgelist <- create_edgelist(tmp_df, type = "mention")
#' }
#' @importFrom rlang .data
#' @export
create_edgelist <-
  function(df, type = "all") {

    filtered_df <- filter_by_tweet_type(df, type)

    if(type == "reply") {col_screen_name <- "reply_to_screen_name"}
    if(type == "retweet") {col_screen_name <- "retweet_screen_name"}
    if(type == "quote") {col_screen_name <- "quoted_screen_name"}

    if(type == "mention") {
      col_screen_name <- "mentions_screen_name"
      filtered_df <-
        tidyr::unnest(filtered_df, !!as.symbol(col_screen_name)
        )
    }

    if(type %in% c("reply", "retweet", "quote", "mention")) {
      ifelse(nrow(filtered_df) > 0,
             el <-
               dplyr::select(filtered_df,
                             sender =
                               `$`(.data, screen_name),
                             receiver =
                               `$`(.data, !!as.symbol(col_screen_name))
               ),
             el <-
               tibble::tibble(sender = as.character(),
                              receiver = as.character()
               )
      )
      el <- dplyr::mutate(el, edge_type = type)
    }

    if(type == "all") {
      el <-
        tibble::tibble(sender = as.character(),
                       receiver = as.character(),
                       edge_type = as.character()
        )

      el <-
        dplyr::bind_rows(el,
                         create_edgelist(df, "reply"),
                         create_edgelist(df, "retweet"),
                         create_edgelist(df, "quote"),
                         create_edgelist(df, "mention")
        )
    }

    el
  }
