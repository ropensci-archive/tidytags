
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidytags <img src="man/figures/tidytags-logo.png" align="right" width="120" />

[![Travis build
status](https://travis-ci.com/bretsw/tidytags.svg?branch=master)](https://travis-ci.com/bretsw/tidytags)
[![codecov](https://codecov.io/gh/bretsw/tidytags/branch/master/graph/badge.svg)](https://codecov.io/gh/bretsw/tidytags)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![license](https://img.shields.io/badge/license-GPL3-9cf.svg)](https://www.gnu.org/licenses/gpl.html)

Simple Collection and Powerful Analysis of Twitter Data

## Overview

{tidytags} coordinates the simplicity of collecting tweets over time
with a [Twitter Archiving Google Sheet](https://tags.hawksey.info/)
(TAGS) and the utility of the [{rtweet} package](https://rtweet.info/)
for processing and preparing additional Twitter metadata. {tidytags}
also introduces functions developed to facilitate systematic yet
flexible analyses of data from Twitter.

## Installation

Soon, you will be able to install the released version of {tidytags}
from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("tidytags")
```

You can also install the development version of {tidytags} from GitHub
with:

``` r
install.packages("devtools")
devtools::install_github("bretsw/tidytags")
```

## Usage

{tidytags} should be used in strict accordance with Twitter’s [developer
terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases).

## Setup

For help with initial {tidytags} setup, see the [Getting started with
tidytags](https://bretsw.github.io/tidytags/articles/setup.html)
vignette.

## {tidytags} core functions

### read\_tags()

At its most basic level, {tidytags} allows you to work with a [Twitter
Archiving Google Sheet](https://tags.hawksey.info/) (TAGS) in R. This is
done with the [{googlesheets4}
package](https://CRAN.R-project.org/package=googlesheets4). One
requirement for using the {googlesheets4} package is that your TAGS
tracker has been “published to the web.” To do this, with the TAGS page
open in a web browser, go to `File >> Publish to the web`. The `Link`
field should be ‘Entire document’ and the `Embed` field should be ‘Web
page.’ If everything looks right, then click the `Publish` button. Next,
click the `Share` button in the top right corner of the Google Sheets
window, select `Get shareable link`, and set the permissions to ‘Anyone
with the link can view.’ The URL needed for R is simply the URL at the
top of the web browser, just copy and paste at this point. Be sure to
put quotations marks around the URL when entering it into `read_tags()`.

At this point, you can view or read your TAGS archive into R using
`read_tags()`.

### pull\_tweet\_data()

With a TAGS archive imported into R, {tidytags} allows you to gather
quite a bit more information related to the collected tweets with the
`pull_tweet_data()` function. This function uses the [{rtweet}
package](https://rtweet.info/) (via `rtweet::lookup_statuses()`) to
query the Twitter API. Using {rtweet} requires Twitter API keys
associated with an approved developer account. Fortunately, the {rtweet}
vignette, [Obtaining and using access
tokens](https://rtweet.info/articles/auth.html), provides a very
thorough guide to obtaining Twitter API keys. We recommend the second
suggested method listed in the {rtweet} vignette, “2. Access
token/secret method.” Following these directions, you will run the
`rtweet::create_token()` function, which saves your Twitter API keys to
the `.Renviron` file. You can also edit this file directly using the
`usethis::edit_r_environ(scope='user')` function.

### geocode\_tags()

Another area to explore is where tweeters in the dataset are from (or,
at least, the location they self-identify in their Twitter profiles).
{tidytags} makes this straightforward with the `geocode_tags()`
function. Note that `geocode_tags()` should be used after additional
metadata has been retrieved with `tidytags::pull_tweet_data()`.

The `geocode_tags()` function pulls from the Google Geocoding API, which
requires a Google Geocoding API Key. You can easily secure a key through
Google Cloud Platform; [read more
here](https://developers.google.com/maps/documentation/geocoding/get-api-key).
We recommend saving your Google Geocoding API Key in the `.Renviron`
file as **Google\_API\_key**. You can quickly access this file using the
R code `usethis::edit_r_environ(scope='user')`. Add a line to this file
that reads: `Google_API_key="PasteYourGoogleKeyInsideTheseQuotes"`. To
read your key into R, use the code `Sys.getenv('Google_API_key')`. Note
that the `geocode_tags()` function retrieves your saved API key
automatically and securely. Once you’ve saved the `.Renviron` file, quit
your R session and restart. The function `geocode_tags()` will work for
you from now on.

## Learning more about tidytags

For a walkthrough of numerous additional {tidytags} functions, see the
[Using tidytags with a conference
hashtag](https://bretsw.github.io/tidytags/articles/tidytags-with-conf-hashtags.html)
vignette.

## Getting help

{tidytags} is still a work in progress, so we fully expect that there
are still some bugs to work out and functions to document better. If you
find an issue, have a question, or think of something that you really
wish {tidytags} would do for you, don’t hesitate to [email
Bret](mailto:bret@bretsw.com) or reach out on Twitter:
\[@bretsw\](<https://twitter.com/bretsw>),
\[@jrosenberg6432\](<https://twitter.com/jrosenberg6432>), and
\[@spgreenhalgh\](<https://twitter.com/spgreenhalgh>).

You can also [submit an issue on
Github](https://github.com/bretsw/tidytags/issues/).

## Future collaborations

This package is still in development, and we welcome new contributors.
Please reach out through the same channels as “Getting help.”

## License

The {tidytags} package is licensed under a *GNU General Public License
v3.0*, or [GPL-3](https://choosealicense.com/licenses/lgpl-3.0/). For
background on why we chose this license, read Hadley Wickham’s take on
[R package licensing](http://r-pkgs.had.co.nz/description.html#license).
