#' Create an edgelist where interaction is defined by replying
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{create_replies_edgelist()} pulls out senders and receivers of reply
#'   tweets and adds a new column \code{edge_type}.
#'   \code{create_replies_edgelist()} is a useful function in itself, but is
#'   also used in \code{create_edgelist()}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @return A dataframe edgelist with column names 'sender', 'receiver', and
#'   \code{edge_type}, which in this case the edge type is "reply"
#' @seealso Compare to other \code{tidytags} functions such as
#'   \code{create_retweets_edgelist()}, \code{create_quotes_edgelist()},
#'   \code{create_mentions_edgelist()}, and \code{create_edgelist()}.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#' create_replies_edgelist(tmp_df)
#' }
#' @importFrom rlang .data
#' @export
create_replies_edgelist <-
  function(df) {
    processed_df <- process_tweets(df)

    replies <-
      dplyr::filter(
        processed_df,
        .data$is_reply
      )

    replies <-
      dplyr::select(replies,
        sender = .data$screen_name,
        receiver = .data$reply_to_screen_name
      )

    if (nrow(replies) == 0) {
      replies <-
        dplyr::mutate(replies,
          sender = as.character(.data),
          receiver = as.character(.data)
        )
    }

    replies <-
      dplyr::mutate(replies,
        edge_type = "reply"
      )

    replies
  }

#' Create an edgelist where interaction is defined by retweeting
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{create_retweets_edgelist()} pulls out senders and receivers of
#'   retweets and adds a new column \code{edge_type}.
#'   \code{create_retweets_edgelist()} is a useful function in itself, but is
#'   also used in \code{create_edgelist()}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @return A dataframe edgelist with column names 'sender', 'receiver', and
#'   \code{edge_type}, which in this case the edge type is "retweet"
#' @seealso Compare to other \code{tidytags} functions such as
#'   \code{create_replies_edgelist()}, \code{create_quotes_edgelist()},
#'   \code{create_mentions_edgelist()}, and \code{create_edgelist()}.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#' create_retweets_edgelist(tmp_df)
#' }
#' @importFrom rlang .data
#' @export
create_retweets_edgelist <-
  function(df) {
    processed_df <- process_tweets(df)

    RTs <-
      dplyr::filter(
        processed_df,
        .data$is_retweet
      )

    RTs <-
      dplyr::select(RTs,
        sender = .data$screen_name,
        receiver = .data$retweet_screen_name
      )

    if (nrow(RTs) == 0) {
      RTs <- dplyr::mutate(RTs,
        sender = as.character(.data),
        receiver = as.character(.data)
      )
    }

    RTs <-
      dplyr::mutate(RTs,
        edge_type = "retweet"
      )

    RTs
  }

#' Create an edgelist where interaction is defined by quote-tweeting
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{create_quotes_edgelist()} pulls out senders and receivers of quote
#'   tweets and adds a new column \code{edge_type}.
#'   \code{create_quotes_edgelist()} is a useful function in itself, but is
#'   also used in \code{create_edgelist()}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @return A dataframe edgelist with column names 'sender', 'receiver', and
#'   \code{edge_type}, which in this case the edge type is "quote-tweet"
#' @seealso Compare to other \code{tidytags} functions such as
#'   \code{create_replies_edgelist()}, \code{create_retweets_edgelist()},
#'   \code{create_mentions_edgelist()}, and \code{create_edgelist()}.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#' create_quotes_edgelist(tmp_df)
#' }
#' @importFrom rlang .data
#' @export
create_quotes_edgelist <-
  function(df) {
    processed_df <- process_tweets(df)

    quotes <-
      dplyr::filter(
        processed_df,
        .data$is_quote
      )

    quotes <-
      dplyr::select(quotes,
        sender = .data$screen_name,
        receiver = .data$quoted_screen_name
      )

    if (nrow(quotes) == 0) {
      quotes <-
        dplyr::mutate(quotes,
          sender = as.character(.data),
          receiver = as.character(.data)
        )
    }

    quotes <-
      dplyr::mutate(quotes,
        edge_type = "quote-tweet"
      )

    quotes
  }

#' Create an edgelist where interaction is defined by mentioning
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{create_mentions_edgelist()} pulls out senders and receivers of
#'   mentions and adds a new column \code{edge_type}.
#'   \code{create_mentions_edgelist()} is a useful function in itself, but is
#'   also used in \code{create_edgelist()}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @return A dataframe edgelist with column names 'sender', 'receiver', and
#'   \code{edge_type}, which in this case the edge type is "mention"
#' @seealso Compare to other \code{tidytags} functions such as
#'   \code{create_replies_edgelist()}, \code{create_retweets_edgelist()},
#'   \code{create_quotes_edgelist()}, and \code{create_edgelist()}.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#' create_mentions_edgelist(tmp_df)
#' }
#' @importFrom rlang .data
#' @export
create_mentions_edgelist <-
  function(df) {
    processed_df <- process_tweets(df)
    unnested_df <- tidyr::unnest(
      data = processed_df,
      cols = .data$mentions_screen_name
    )

    mentions <-
      dplyr::select(unnested_df,
        sender = .data$screen_name,
        receiver = .data$mentions_screen_name
      )

    mentions <-
      dplyr::filter(
        mentions,
        !is.na(.data$receiver)
      )

    if (nrow(mentions) == 0) {
      mentions <- dplyr::mutate(mentions,
        sender = as.character(.data),
        receiver = as.character(.data)
      )
    }

    mentions <-
      dplyr::mutate(mentions,
        edge_type = "mention"
      )

    mentions
  }

#' Create an edgelist with several types of interaction
#'
#' Starting with a dataframe returned by \code{pull_tweet_data()},
#'   \code{create_edgelist()} pulls out senders and receivers of reply tweets,
#'   retweets, quote tweets, and mentions, and then adds a new column
#'   \code{edge_type}.
#' @param df A dataframe returned by \code{pull_tweet_data()}
#' @return A dataframe edgelist with column names 'sender', 'receiver', and
#'   \code{edge_type}, which in this case the edge type may be "reply",
#'   "retweet", "quote", or "mention"
#' @seealso Compare to other \code{tidytags} functions such as
#'   \code{create_replies_edgelist()}, \code{create_retweets_edgelist()},
#'   \code{create_quotes_edgelist()}, and \code{create_mentions_edgelist()}.
#' @examples
#'
#' \dontrun{
#'
#' example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
#' tmp_df <- pull_tweet_data(read_tags(example_url), n = 10)
#' edgelist <- create_edgelist(tmp_df)
#' edgelist
#' }
#' @importFrom rlang .data
#' @export
create_edgelist <-
  function(df) {
    reply_edges <- create_replies_edgelist(df)
    retweet_edges <- create_retweets_edgelist(df)
    quote_edges <- create_quotes_edgelist(df)
    mention_edges <- create_mentions_edgelist(df)

    full_edgelist <-
      tibble::tibble(
        sender = character(),
        receiver = character(),
        edge_type = character()
      )

    full_edgelist <-
      dplyr::bind_rows(
        full_edgelist,
        reply_edges,
        retweet_edges,
        quote_edges,
        mention_edges
      )

    full_edgelist
  }
