tidytags development version
=========================

### BREAKING CHANGES

  *  
 
### NEW FEATURES

  *  

### BUG FIXES

  * 


### DOCUMENTATION FIXES

  * 

tidytags 1.1.1 (2023-01-09)
=========================

### BUG FIXES

  * Fixed a bug with **vcr** testing prompted by the **rtweet** update to v1.1 (https://github.com/ropensci/tidytags/issues/90)

tidytags 1.1.0 (2022-11-18)
=========================

### BUG FIXES

  * Fixed another bug in `get_upstream_tweets()` where the column `possibly_sensitive` was sometimes read in as a list, other times as a logical type.
  * Addressed a bug in **vcr v1.1** that was causing **tidytags** tests to error in the CRAN logs (https://cran.r-project.org/web/checks/check_results_tidytags.html).
  * The `setup-vcr.R` file was renamed to `helper-vcr.R` so that it will not be loaded when someone simply installs tidytags, only when package developers compile and test. 
  * In addition, the vcr bug has been addressed by the developers of that package, so **vcr v1.2** is now the minimum suggested version for tidytags. 

tidytags 1.0.3 (2022-10-14)
=========================

### BUG FIXES

  * Fixed a bug in `get_upstream_tweets()` where column names were out of order and caused an error

tidytags 1.0.2 (2022-08-19)
=========================

### DOCUMENTATION FIXES

  * Fixed broken URLs and reduced tarball size in preparation for CRAN resubmission.
  * In function documentation, \dontrun{} instances have been updated to \donttest{}.

tidytags 1.0.1 (2022-08-18)
=========================

### DOCUMENTATION FIXES

  * Cleaned up documentation in preparation for CRAN submission.
 
tidytags 1.0.0 (2022-08-05)
=========================

### BREAKING CHANGES

  * Updated Twitter authentication process to align with breaking changes caused by the rtweet 1.0 release.
  * Updated the process_tweets() function to align with changes in available metadata and new variable names used in rtweet 1.0.
  * Removed the lookup_many_users() function. With the rtweet 1.0 update, user information can be accessed with the rtweet::users_data() function.
  * Updated flag_unknown_upstream() and get_upstream_tweets() to align with new variable names used in rtweet 1.0.
  * Updated filter_by_tweet_type(), create_edgelist(), and add_users_data() to align with new variable names used in rtweet 1.0.
  * Removed the geocode_tags() function because rtweet 1.0 changed how location data is available and also added a new rtweet::lookup_coords() function. Note that at this time, rtweet::lookup_coords() requires a Google Maps API key rather than the OpenCage API we had recommended in earlier versions of tidytags. We still recommend the sf and mapview R packages for working with locations and geocoding.
 
### NEW FEATURES

  * Updated the read_tags() function so that a Google API key is no longer needed to pull tweet data from publicly shared Google Sheets.
  * The process_tweets() function now also adds user information associated with the creator of each status. process_tweets() also now returns a column for the tweet type of each status.

tidytags 0.3.0 (2022-02-04)
=========================

### BUG FIXES

  * Updated to most recent versions of CI tests for R-CMD-check and test coverage.

### DOCUMENTATION FIXES
 
   * Updated paper.md and paper.bib to coincide with submission for peer review at Journal of Open Source Software (JOSS).

tidytags 0.2.1 (2021-12-14)
=========================

### NEW FEATURES

  * Added a new function filter_by_tweet_type() to filter a Twitter dataset to only include statuses of a particular type (e.g., replies, retweets, quote tweets, mentions).
  * Updated the function create_edgelist() to take a "type" argument (e.g., "reply", "retweet", "quote", "mention", "all"). This replaces the need for specialized functions like create_mentions_edgelist().

tidytags 0.2.0 (2021-11-19)
=========================

### NEW FEATURES

  * Added a new function lookup_many_users() to automatically iterate through the Twitter API limit of pulling metadata for only 90,000 users at one time
 
### BUG FIXES
 
  * Updated several function names so as not to mask newer functions imported from {rtweet}, for example, get_mentions() is now create_mentions_edgelist(), and similar updates have been made for function building edgelists from quotes, replies, and retweets
  * Updated tests to work with latest version of {vcr}
  * Made fixes so CI tests would again work with real requests in addition to pre-recorded {vcr} data
 
### DOCUMENTATION FIXES

  * Extensively updated the README doc and Setup vignette to help scaffold {tidytags} setup
  
tidytags 0.1.2 (2021-03-02)
=========================

### BUG FIXES

  * CI tests now work with real requests in addition to pre-recorded vcr data
  * Added a Google API key for accessing a Google Sheet with `read_tags()`
 
### DOCUMENTATION FIXES

  * Clarified process for obtaining an setting up API keys and tokens for Google, Twitter, and OpenCage

tidytags 0.1.1 (2020-11-24)
=========================

### NEW FEATURES

  * Switched to OpenCage for geocoding (previously used Google Maps API)
  * Switched to GitHub Actions (from Travis CI) for CI testing

tidytags 0.1.0 (2020-02-21)
=========================

  * Initial release on GitHub.
