
<!-- README.md is generated from README.Rmd. Please edit that file -->
tidytags <img src="man/figures/tidytags-logo.png" align="right" width="120" />
==============================================================================

Simple Collection and Powerful Analysis of Twitter Data

Overview
--------

The goal of **tidytags** is to sync together (a) the simplicity of collecting tweets over time with a [Twitter Archiving Google Sheet](https://tags.hawksey.info/) (TAGS), (b) the utility of the [rtweet package](https://rtweet.info/) for processing and preparing additional Twitter metadata, and (c) a collection of different analytic functions we have developed during our own social media research.

Installation
------------

Soon, you will be able to install the released version of **tidytags** from [CRAN](https://CRAN.R-project.org) with:

``` r
#install.packages("tidytags")
```

You can also install the development version of **tidytags** from GitHub with:

``` r
install.packages("devtools")
devtools::install_github("bretsw/tidytags")
```

Usage
-----

At its most basic level, **tidytags** allows you to work with a [Twitter Archiving Google Sheet](https://tags.hawksey.info/) (TAGS) in R. This is done with the [googlesheets package](https://cran.r-project.org/web/packages/googlesheets/vignettes/basic-usage.html).

``` r
library(tidytags)
```

1.  the utility of the [rtweet package](https://rtweet.info/) for processing and preparing additional Twitter metadata, and (c) a collection of different analytic functions we have developed during our own social media research.

``` r
library(tidytags)
```

Learning tidytags
-----------------

For a walkthrough of many of the **tidytags** functions, visit the [Vignettes webpage](https://bretsw.github.io/tidytags/articles/tidytags-with-conf-hashtags.html).

Getting help
------------

**tidytags** is still a work in progress, so we fully expect that there are still some bugs to work out and functions to document better. If you find an issue, have a question, or think of something that you really wish **tidytags** would do for you, don't hesitate to [email Bret](mailto:bret@bretsw.com) or reach out on Twitter: \[@bretsw\](<https://twitter.com/bretsw>), \[@jrosenberg6432\](<https://twitter.com/jrosenberg6432>), and \[@spgreenhalgh\](<https://twitter.com/spgreenhalgh>).

Future collaborations
---------------------

This is package is still in development, and we welcome new contributors. Just reach out through the same channels as "Getting help."

License
-------

The **tidytags** package is licensed under a GNU General Public License v3.0, or [GPL-3](https://choosealicense.com/licenses/lgpl-3.0/). For background on why we chose this license, read Hadley Wickham's take on [R package licensing](http://r-pkgs.had.co.nz/description.html#license).
