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
