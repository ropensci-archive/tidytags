library(vcr)
library(rtweet)

vcr_dir <- vcr::vcr_test_path("fixtures")

if (!nzchar(Sys.getenv('OPENCAGE_KEY'))) {
  if (dir.exists(vcr_dir)) {
    Sys.setenv('OPENCAGE_KEY' = "fake_key")
  } else {
    stop("No API key nor cassettes, tests cannot be run.",
         call. = FALSE)
  }
}

if (!nzchar(Sys.getenv('TWITTER_PAT'))) {
  if (dir.exists(vcr_dir)) {
    rtweet::create_token(
      app = "fake_twitter_app",
      consumer_key = "fake_consumer_key",
      consumer_secret = "fake_consumer_secret",
      access_token = "fake_access_token",
      access_secret = "fake_access_secret",
      set_renv = TRUE
    )
  } else {
    stop("No API key nor cassettes, tests cannot be run.",
         call. = FALSE)
  }
}

invisible(vcr::vcr_configure(
  turned_off = FALSE,
  dir = vcr_dir,
  filter_sensitive_data =
    list("<<<my_opencage_api_key>>>" = Sys.getenv('OPENCAGE_KEY'),
         "<<<my_twitter_api_key>>>" = Sys.getenv('TWITTER_PAT')
    ),
   filter_request_headers = list(Authorization = "<<<not-my-bearer-token>>>")
))
