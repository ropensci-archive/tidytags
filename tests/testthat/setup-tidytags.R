library(vcr)
library(rtweet)

vcr_dir <- vcr::vcr_test_path("fixtures")

if (!nzchar(Sys.getenv('OPENCAGE_KEY'))) {
  if (dir.exists(vcr_dir)) {
    Sys.setenv('OPENCAGE_KEY'="11a1111a111a1a1a1a111111a1aa11a1")
  } else {
    stop("No API key nor cassettes, tests cannot be run.",
         call. = FALSE)
  }
}

if (!nzchar(Sys.getenv('TWITTER_PAT'))) {
  if (dir.exists(vcr_dir)) {
    rtweet::create_token(
      app = "faketwitterappname",
      consumer_key = "fakeconsumerkey12345",
      consumer_secret = "fakeconsumersecret12345",
      access_token = "fakeaccesstoken12345",
      access_secret = "fakeaccesssecret12345",
      set_renv = TRUE
    )
    if (tolower(Sys.info()['sysname']) == "windows") {
      rtweet:::load_tokens("C:\Users\runneradmin\Documents\.rtweet_token.rds")
    }

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

print(rtweet:::twitter_pat())
