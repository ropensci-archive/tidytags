library(vcr)
library(rtweet)

vcr_dir <- vcr::vcr_test_path("fixtures")

if (!nzchar(Sys.getenv('TWITTER_BEARER_TOKEN'))) {
  if (dir.exists(vcr_dir)) {
    app <-
      rtweet::rtweet_app(bearer_token = Sys.getenv("TWITTER_BEARER_TOKEN"))
    rtweet::auth_as(app)
  } else {
    stop("No Twitter token nor cassettes, tests cannot be run.",
         call. = FALSE)
  }
}

invisible(vcr::vcr_configure(
  turned_off = FALSE,
  dir = vcr_dir,
  filter_sensitive_data =
    list("<<<my_twitter_api_token>>>" = Sys.getenv('TWITTER_PAT')
    ),
   filter_request_headers = list(Authorization = "<<<not-my-bearer-token>>>")
))
