
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidytags <img src="man/figures/tidytags-logo.png" align="right" width="120" />

<!-- badges: start -->

[![R build
status](https://github.com/bretsw/tidytags/workflows/R-CMD-check/badge.svg)](https://github.com/bretsw/tidytags/actions)
[![codecov](https://codecov.io/gh/bretsw/tidytags/branch/master/graph/badge.svg)](https://codecov.io/gh/bretsw/tidytags)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![license](https://img.shields.io/badge/license-GPL3-9cf.svg)](https://www.gnu.org/licenses/gpl.html)
<!-- badges: end -->

Simple Collection and Powerful Analysis of Twitter Data

## Overview

{tidytags} coordinates the simplicity of collecting tweets over time
with a [Twitter Archiving Google Sheet](https://tags.hawksey.info/)
(TAGS) and the utility of the [{rtweet} package](https://rtweet.info/)
for processing and preparing additional Twitter metadata. {tidytags}
also introduces functions developed to facilitate systematic yet
flexible analyses of data from Twitter.

## Installation

You can install the development version of {tidytags} from GitHub:

``` r
install.packages("devtools")
devtools::install_github("bretsw/tidytags")
```

Soon, you will be able to install the released version of {tidytags}
from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("tidytags")
```

## Usage

To load {tidytags}, start with the `library()` function:

``` r
library(tidytags)
```

## Setup

For help with initial {tidytags} setup, see the [Getting started with
tidytags](https://bretsw.github.io/tidytags/articles/setup.html)
vignette. Specifically, this guide offers help for three pain points:

1.  Making sure your TAGS tracker can be accessed
2.  Getting and storing Twitter API keys
3.  Getting and storing a Google Geocoding API key

## {tidytags} core functions

### read\_tags()

At its most basic level, {tidytags} allows you to import data from a
[Twitter Archiving Google Sheet](https://tags.hawksey.info/) (TAGS) into
R. This is done with the [{googlesheets4}
package](https://CRAN.R-project.org/package=googlesheets4). One
requirement for using the {googlesheets4} package is that your TAGS
tracker has been “published to the web.” (See the [Getting started with
tidytags](https://bretsw.github.io/tidytags/articles/setup.html)
vignette, Pain Point \#1, if you need help with this.) Once a TAGS
tracker has been published to the web, you can import the TAGS archive
into R using `read_tags()`.

### pull\_tweet\_data()

With a TAGS archive imported into R, {tidytags} allows you to gather
quite a bit more information related to the collected tweets with the
`pull_tweet_data()` function. This function uses the [{rtweet}
package](https://rtweet.info/) (via `rtweet::lookup_statuses()`) to
query the Twitter API. This process requires Twitter API keys associated
with an approved Twitter developer account. (See the [Getting started
with tidytags](https://bretsw.github.io/tidytags/articles/setup.html)
vignette, Pain Point \#2, if you need help with this.)

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
[@bretsw](https://twitter.com/bretsw) and
[@jrosenberg6432](https://twitter.com/jrosenberg6432).

You can also [submit an issue on
Github](https://github.com/bretsw/tidytags/issues/).

You may also wish too try some general troubleshooting strategies:

  - Try to find out what the specific problem is
      - Identify what is *not* causing the problem
  - “Unplug and plug it back in” - restart R, close and reopen R
  - Reach out to others\! Sharing what is causing an issue can often
    help to clarify the problem.
      - RStudio Community - <https://community.rstudio.com/> (highly
        recommended\!)
      - Twitter hashtag: \#rstats
  - General strategies on learning more:
    <https://datascienceineducation.com/c17.html>

## Considerations Related to Ethics, Data Privacy, and Human Subjects Research

{tidytags} should be used in strict accordance with Twitter’s [developer
terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases).

Although most Institutional Review Boards (IRBs) consider the Twitter
data that {tidytags} analyzes to *not* necessarily be human subjects
research, there remain ethical considerations pertaining to the use of
the {tidytags} package that should be discussed.

Even if {tidytags} use is not for research purposes (or if an IRB
determines that a study is not human subjects research), “the release of
personally identifiable or sensitive data is potentially harmful,” as
noted in the [rOpenSci Packages
guide](https://devguide.ropensci.org/policies.html#ethics-data-privacy-and-human-subjects-research).
Therefore, although you *can* collect Twitter data (and you *can* use
{tidytags} to analyze it), we urge care and thoughtfulness regarding how
you analyze the data and communicate the results. In short, please
remember that most (if not all) of the you collect may be about
people—and [those people may not like the idea of their data being
analyzed or included in
research](https://journals.sagepub.com/doi/full/10.1177/2056305118763366).

We recommend [the Association of Internet Researchers’ (AoIR) resources
related to conducting analyses in ethical
ways](https://aoir.org/ethics/) when working with data about people.
AoIR’s [ethical guidelines](https://aoir.org/reports/ethics3.pdf) may be
especially helpful for navigating tensions related to collecting,
analyzing, and sharing social media data.

{tidytags} should be used in strict accordance with Twitter’s [developer
terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases).

## Future collaborations

This package is still in development, and we welcome new contributors.
Please reach out through the same channels as “Getting help.”

## License

The {tidytags} package is licensed under a *GNU General Public License
v3.0*, or [GPL-3](https://choosealicense.com/licenses/lgpl-3.0/). For
background on why we chose this license, read Hadley Wickham’s take on
[R package licensing](http://r-pkgs.had.co.nz/description.html#license).
