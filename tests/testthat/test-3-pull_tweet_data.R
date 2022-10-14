test_that("pull_tweet_data() is able to retrieve additional metadata starting
          with dataframe", {

            vcr::use_cassette("sample_tags", {
              example_url <- "18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8"
              sample_tags <- head(read_tags(example_url), 200)
              sample_tags <- sample_tags[,1:(length(sample_tags)-1)]
            })

            vcr::use_cassette("metadata_from_rtweet", {
              app <- rtweet::rtweet_app(bearer_token =
                                          Sys.getenv("TWITTER_BEARER_TOKEN"))
              rtweet::auth_as(app)
              from_df <- pull_tweet_data(sample_tags, n = 10)
            })

            testthat::expect_equal(is.data.frame(from_df), TRUE)
            testthat::expect_named(from_df)
            testthat::expect_true("created_at" %in% names(from_df))
            testthat::expect_true("id_str" %in% names(from_df))
            testthat::expect_true("full_text" %in% names(from_df))
            testthat::expect_true("entities" %in% names(from_df))
            testthat::expect_true("in_reply_to_status_id_str" %in% names(from_df))
            testthat::expect_true("user_id_str" %in% names(from_df))
            testthat::expect_true("screen_name" %in% names(from_df))
            testthat::expect_true("location" %in% names(from_df))
            testthat::expect_true("followers_count" %in% names(from_df))
            testthat::expect_true("friends_count" %in% names(from_df))
            testthat::expect_gt(ncol(from_df), ncol(sample_tags))
            testthat::expect_lte(nrow(from_df), nrow(sample_tags))
          })



test_that("pull_tweet_data() is able to retrieve additional metadata starting
          with tweet IDs", {

            vcr::use_cassette("sample_tags", {
              sample_tags <-
                read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
            })

            vcr::use_cassette("metadata_from_ids", {
              app <- rtweet::rtweet_app(bearer_token =
                                          Sys.getenv("TWITTER_BEARER_TOKEN"))
              rtweet::auth_as(app)
              from_ids <- pull_tweet_data(id_vector =
                                            sample_tags$id_str, n = 10)
            })

            testthat::expect_equal(is.data.frame(from_ids), TRUE)
            testthat::expect_named(from_ids)
            testthat::expect_true("created_at" %in% names(from_ids))
            testthat::expect_true("id_str" %in% names(from_ids))
            testthat::expect_true("full_text" %in% names(from_ids))
            testthat::expect_true("entities" %in% names(from_ids))
            testthat::expect_true("in_reply_to_status_id_str" %in%
                                    names(from_ids))
            testthat::expect_true("user_id_str" %in% names(from_ids))
            testthat::expect_true("screen_name" %in% names(from_ids))
            testthat::expect_true("location" %in% names(from_ids))
            testthat::expect_true("followers_count" %in% names(from_ids))
            testthat::expect_true("friends_count" %in% names(from_ids))
            testthat::expect_gt(ncol(from_ids), ncol(sample_tags))
            testthat::expect_lte(nrow(from_ids), nrow(sample_tags))
          })



test_that("pull_tweet_data() is able to retrieve additional metadata starting
          with tweet URLs", {

            vcr::use_cassette("sample_tags", {
              sample_tags <-
                read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
            })

            vcr::use_cassette("metadata_from_urls", {
              app <- rtweet::rtweet_app(bearer_token =
                                          Sys.getenv("TWITTER_BEARER_TOKEN"))
              rtweet::auth_as(app)
              from_urls <- pull_tweet_data(url_vector =
                                             sample_tags$status_url, n = 10)
            })

            testthat::expect_equal(is.data.frame(from_urls), TRUE)
            testthat::expect_named(from_urls)
            testthat::expect_true("created_at" %in% names(from_urls))
            testthat::expect_true("id_str" %in% names(from_urls))
            testthat::expect_true("full_text" %in% names(from_urls))
            testthat::expect_true("entities" %in% names(from_urls))
            testthat::expect_true("in_reply_to_status_id_str" %in%
                                    names(from_urls))
            testthat::expect_true("user_id_str" %in% names(from_urls))
            testthat::expect_true("screen_name" %in% names(from_urls))
            testthat::expect_true("location" %in% names(from_urls))
            testthat::expect_true("followers_count" %in% names(from_urls))
            testthat::expect_true("friends_count" %in% names(from_urls))
            testthat::expect_gt(ncol(from_urls), ncol(sample_tags))
            testthat::expect_lte(nrow(from_urls), nrow(sample_tags))
          })



test_that("pull_tweet_data() output keeps columns in consistent order", {
  vcr::use_cassette("tweet_ids", {
    app <- rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
    rtweet::auth_as(app)

    colnames0a <- colnames(pull_tweet_data(id_vector = "X"))
    colnames0b <- colnames(pull_tweet_data(id_vector = "1578252090102751232"))
    colnames1 <- colnames(pull_tweet_data(id_vector = "1580002144631279616"))
    colnames2 <- colnames(pull_tweet_data(id_vector = "1578824308260237312"))
    colnames3 <- colnames(pull_tweet_data(id_vector = "1580186891151777792"))
    colnames4 <- colnames(pull_tweet_data(id_vector = "1580212580249133056"))
    colnames5 <- colnames(pull_tweet_data(id_vector = "1580172355699023872"))
    colnames6 <- colnames(pull_tweet_data(id_vector = "1579969347942219776"))
  })

  expect_null(colnames0a)
  expect_null(colnames0b)

  a <- tibble::tibble(colnames1, colnames2, colnames3,
                      colnames4, colnames5, colnames6)
  b <- apply(a, 1, function(x){length(unique(x))})
  expect_true(all(b == 1))

  expected_names <-
    c("created_at", "id", "id_str", "text", "full_text", "truncated",
      "entities", "source", "in_reply_to_status_id",
      "in_reply_to_status_id_str", "in_reply_to_user_id",
      "in_reply_to_user_id_str", "in_reply_to_screen_name", "geo",
      "coordinates", "place", "contributors", "is_quote_status",
      "retweet_count", "favorite_count", "favorited", "favorited_by",
      "retweeted", "scopes", "lang", "possibly_sensitive",
      "display_text_width", "display_text_range", "retweeted_status",
      "quoted_status", "quoted_status_id", "quoted_status_id_str",
      "quoted_status_permalink", "quote_count", "timestamp_ms", "reply_count",
      "filter_level", "metadata", "query", "withheld_scope",
      "withheld_copyright", "withheld_in_countries",
      "possibly_sensitive_appealable", "user_id", "user_id_str", "name",
      "screen_name", "location", "description", "url", "protected",
      "followers_count", "friends_count", "listed_count", "user_created_at",
      "favourites_count", "verified", "statuses_count",
      "profile_image_url_https", "profile_banner_url", "default_profile",
      "default_profile_image", "user_withheld_in_countries", "derived",
      "user_withheld_scope", "user_entities")
  expect_true(all(expected_names == colnames1))
  expect_true(all(expected_names == colnames2))
  expect_true(all(expected_names == colnames3))
  expect_true(all(expected_names == colnames4))
  expect_true(all(expected_names == colnames5))
  expect_true(all(expected_names == colnames6))
})
