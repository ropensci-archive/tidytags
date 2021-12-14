
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidytags <img src="man/figures/tidytags-logo.png" align="right" width="120" />

##### *Importing and Analyzing Twitter Data Collected with Twitter Archiving Google Sheets*

<!-- badges: start -->
<!-- For additional badges for CRAN, see https://docs.ropensci.org/drake/ -->
<table class="table">
<thead>
<tr class="header">
<th align="left">
Usage
</th>
<th align="left">
Release
</th>
<th align="left">
Development
</th>
<th align="left">
Checks
</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">
<a href="https://choosealicense.com/licenses/mit/"><img src="https://img.shields.io/badge/licence-MIT-9cf.svg" alt="Licence"></a>
</td>
<td align="left">
<a href="https://github.com/ropensci/software-review/issues/382"><img src="https://badges.ropensci.org/382_status.svg" alt="rOpenSci Peer Review"></a>
</td>
<td align="left">
<a href="https://www.repostatus.org/#active"><img src="https://www.repostatus.org/badges/latest/active.svg" alt="Status"></a>
</td>
<td align="left">
<a href="https://github.com/bretsw/tidytags/actions"><img src="https://github.com/bretsw/tidytags/workflows/R-CMD-check/badge.svg" alt="Check"></a>
</td>
</tr>
<tr class="even">
<td align="left">
<a href="https://cran.r-project.org/"><img src="https://img.shields.io/badge/R%3E%3D-4.1.0-blue.svg" alt="Minimal R Version"></a>
</td>
<td align="left">
</td>
<td align="left">
<a href="https://github.com/bretsw/tidytags/commits/main"><img src="https://img.shields.io/github/last-commit/bretsw/tidytags.svg" alt="Last Commit"></a>
</td>
<td align="left">
<a href="https://codecov.io/gh/bretsw/tidytags?branch=main"><img src="https://codecov.io/gh/bretsw/tidytags/coverage.svg?branch=main" alt="Codecov"></a>
</td>
</tr>
<tr class="odd">
<td align="left">
</td>
<td align="left">
</td>
<td align="left">
<a href="https://www.tidyverse.org/lifecycle/#maturing"><img src="https://img.shields.io/badge/lifecycle-maturing-blue.svg" alt='Lifecycle'></a>
</td>
<td align="left">
</td>
</tr>
</tbody>
</table>
<!-- badges: end -->

------------------------------------------------------------------------

## Overview

{tidytags} coordinates the simplicity of collecting tweets over time
with a [Twitter Archiving Google Sheet](https://tags.hawksey.info/)
(TAGS) and the utility of the [{rtweet}
package](https://docs.ropensci.org/rtweet/index.html) for processing and
preparing additional Twitter metadata. {tidytags} also introduces
functions developed to facilitate systematic yet flexible analyses of
data from Twitter.

------------------------------------------------------------------------

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

To load {tidytags}, start with the `library()` function:

``` r
library(tidytags)
```

------------------------------------------------------------------------

## Setup

For help with initial {tidytags} setup, see the [Getting started with
tidytags](https://bretsw.github.io/tidytags/articles/setup.html)
vignette. Specifically, this guide offers help for four key tasks:

1.  Making sure your TAGS tracker can be accessed
2.  Getting and storing a Google API key
3.  Getting and storing Twitter API tokens
4.  Getting and storing an OpenCage Geocoding API key

------------------------------------------------------------------------

## Usage

To test the {tidytags} package, you can use an openly shared TAGS
tracker that has been collecting tweets associated with the AECT 2019
since September 30, 2019. This is the same TAGS tracker used in the
[Using tidytags with a conference hashtag
vignette](https://bretsw.github.io/tidytags/articles/tidytags-with-conf-hashtags.html).

------------------------------------------------------------------------

## Core Functions

### read\_tags()

At its most basic level, {tidytags} allows you to import data from a
[Twitter Archiving Google Sheet](https://tags.hawksey.info/) (TAGS) into
R. This is done with the [{googlesheets4}
package](https://CRAN.R-project.org/package=googlesheets4). One
requirement for using the {googlesheets4} package is that your TAGS
tracker has been “published to the web.” See the [Getting started with
tidytags](https://bretsw.github.io/tidytags/articles/setup.html)
vignette, Pain Point \#1, if you need help with this.

Once a TAGS tracker has been published to the web, you can import the
TAGS archive into R using `read_tags()`. See the [Getting started with
tidytags](https://bretsw.github.io/tidytags/articles/setup.html)
vignette, Pain Point \#2, to set up API access to Google Sheets like the
TAGS tracker.

### pull\_tweet\_data()

With a TAGS archive imported into R, {tidytags} allows you to gather
quite a bit more information related to the collected tweets with the
`pull_tweet_data()` function. This function uses the [{rtweet}
package](https://docs.ropensci.org/rtweet/index.html) (via
`rtweet::lookup_tweets()`) to query the Twitter API. This process
requires Twitter API keys associated with an approved Twitter developer
account. See the [Getting started with
tidytags](https://bretsw.github.io/tidytags/articles/setup.html)
vignette, Pain Point \#3, if you need help with this.

------------------------------------------------------------------------

## Learning More About {tidytags}

For a walkthrough of numerous additional {tidytags} functions, see the
[Using tidytags with a conference
hashtag](https://bretsw.github.io/tidytags/articles/tidytags-with-conf-hashtags.html)
vignette.

------------------------------------------------------------------------

## Getting Help

{tidytags} is still a work in progress, so we fully expect that there
are still some bugs to work out and functions to document better. If you
find an issue, have a question, or think of something that you really
wish {tidytags} would do for you, don’t hesitate to [email
Bret](mailto:bret@bretsw.com) or reach out on Twitter:
[@bretsw](https://twitter.com/bretsw) and
[@jrosenberg6432](https://twitter.com/jrosenberg6432).

You can also [submit an issue on
Github](https://github.com/bretsw/tidytags/issues/).

You may also wish to try some general troubleshooting strategies:

-   Try to find out what the specific problem is
    -   Identify what is *not* causing the problem
-   “Unplug and plug it back in” - restart R, close and reopen R
-   Reach out to others! Sharing what is causing an issue can often help
    to clarify the problem.
    -   RStudio Community - <https://community.rstudio.com/> (highly
        recommended!)
    -   Twitter hashtag: \#rstats
-   General strategies on learning more:
    <https://datascienceineducation.com/c17.html>

------------------------------------------------------------------------

## Considerations Related to Ethics, Data Privacy, and Human Subjects Research

**{tidytags} should be used in strict accordance with Twitter’s
[developer
terms](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases).**

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
remember that most (if not all) of the data you collect may be about
people—and [those people may not like the idea of their data being
analyzed or included in
research](https://journals.sagepub.com/doi/full/10.1177/2056305118763366).

We recommend [the Association of Internet Researchers’ (AoIR) resources
related to conducting analyses in ethical
ways](https://aoir.org/ethics/) when working with data about people.
AoIR’s [ethical guidelines](https://aoir.org/reports/ethics3.pdf) may be
especially helpful for navigating tensions related to collecting,
analyzing, and sharing social media data.

------------------------------------------------------------------------

## Contributing

If you encounter an obvious bug for which there is not already an
[active issue](https://github.com/bretsw/tidytags/issues), please
[create a new issue](https://github.com/bretsw/tidytags/issues/new) with
all code used (preferably a reproducible example) on Github.

If you would like to become a more involved contributor, please read the
[Contributing
Guide](https://github.com/bretsw/tidytags/blob/master/CONTRIBUTING.md).
All contributors, from those fixing typos to adding new functionality,
must adhere to the [Code of
Conduct](https://github.com/bretsw/tidytags/blob/master/CODE_OF_CONDUCT.md).

------------------------------------------------------------------------

## How to Cite This Package in Publications

You can cite this package like this: “we collected, processed, and
analyzed Twitter data using the tidytags R package (Staudt Willet &
Rosenberg, 2021)”. Here is the full bibliographic reference to include
in your reference list:

> Staudt Willet, K. B., & Rosenberg, J. M. (2021). tidytags: Importing
> and analyzing Twitter data collected with Twitter Archiving Google
> Sheets. <https://github.com/bretsw/tidytags> (R package version 0.2.0)

------------------------------------------------------------------------

## License [![license](https://img.shields.io/badge/licence-MIT-9cf.svg)](https://choosealicense.com/licenses/mit/)

The {tidytags} package is licensed under the [*MIT
License*](https://choosealicense.com/licenses/mit/). For background on
why we chose this license, read this chapter on [R package
licensing](https://r-pkgs.org/license.html).
