
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

``` r
library(tidytags)
```

Learning tidytags
-----------------

Getting help
------------

Future collaborations
---------------------

This is package is still in development, and we welcome new contributors.

License
-------

The **tidytags** package is licensed under a GNU General Public License v3.0, or [GPL-3](https://choosealicense.com/licenses/lgpl-3.0/). For background on why we chose this license, read Hadley's take at <http://r-pkgs.had.co.nz/description.html#license>.

``` r
devtools::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value                       
#>  version  R version 3.6.2 (2019-12-12)
#>  os       macOS Mojave 10.14.6        
#>  system   x86_64, darwin15.6.0        
#>  ui       X11                         
#>  language (EN)                        
#>  collate  en_US.UTF-8                 
#>  ctype    en_US.UTF-8                 
#>  tz       America/New_York            
#>  date     2020-02-21                  
#> 
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package     * version date       lib source                          
#>  assertthat    0.2.1   2019-03-21 [1] CRAN (R 3.6.0)                  
#>  backports     1.1.5   2019-10-02 [1] CRAN (R 3.6.0)                  
#>  callr         3.4.2   2020-02-12 [1] CRAN (R 3.6.0)                  
#>  cli           2.0.1   2020-01-08 [1] CRAN (R 3.6.0)                  
#>  crayon        1.3.4   2017-09-16 [1] CRAN (R 3.6.0)                  
#>  desc          1.2.0   2018-05-01 [1] CRAN (R 3.6.0)                  
#>  devtools      2.2.2   2020-02-17 [1] CRAN (R 3.6.0)                  
#>  digest        0.6.24  2020-02-12 [1] CRAN (R 3.6.0)                  
#>  ellipsis      0.3.0   2019-09-20 [1] CRAN (R 3.6.0)                  
#>  evaluate      0.14    2019-05-28 [1] CRAN (R 3.6.0)                  
#>  fansi         0.4.1   2020-01-08 [1] CRAN (R 3.6.0)                  
#>  fs            1.3.1   2019-05-06 [1] CRAN (R 3.6.0)                  
#>  glue          1.3.1   2019-03-12 [1] CRAN (R 3.6.0)                  
#>  htmltools     0.4.0   2019-10-04 [1] CRAN (R 3.6.0)                  
#>  knitr         1.28    2020-02-06 [1] CRAN (R 3.6.0)                  
#>  magrittr      1.5     2014-11-22 [1] CRAN (R 3.6.0)                  
#>  memoise       1.1.0   2017-04-21 [1] CRAN (R 3.6.0)                  
#>  pkgbuild      1.0.6   2019-10-09 [1] CRAN (R 3.6.0)                  
#>  pkgload       1.0.2   2018-10-29 [1] CRAN (R 3.6.0)                  
#>  prettyunits   1.1.1   2020-01-24 [1] CRAN (R 3.6.0)                  
#>  processx      3.4.2   2020-02-09 [1] CRAN (R 3.6.0)                  
#>  ps            1.3.2   2020-02-13 [1] CRAN (R 3.6.0)                  
#>  R6            2.4.1   2019-11-12 [1] CRAN (R 3.6.0)                  
#>  Rcpp          1.0.3   2019-11-08 [1] CRAN (R 3.6.0)                  
#>  remotes       2.1.1   2020-02-15 [1] CRAN (R 3.6.0)                  
#>  rlang         0.4.4   2020-01-28 [1] CRAN (R 3.6.0)                  
#>  rmarkdown     2.1     2020-01-20 [1] CRAN (R 3.6.0)                  
#>  rprojroot     1.3-2   2018-01-03 [1] CRAN (R 3.6.0)                  
#>  sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 3.6.0)                  
#>  stringi       1.4.6   2020-02-17 [1] CRAN (R 3.6.0)                  
#>  stringr       1.4.0   2019-02-10 [1] CRAN (R 3.6.0)                  
#>  testthat      2.3.1   2019-12-01 [1] CRAN (R 3.6.0)                  
#>  tidytags    * 0.1.0   2020-02-11 [1] Github (bretsw/tidytags@12e50ab)
#>  usethis       1.5.1   2019-07-04 [1] CRAN (R 3.6.0)                  
#>  withr         2.1.2   2018-03-15 [1] CRAN (R 3.6.0)                  
#>  xfun          0.12    2020-01-13 [1] CRAN (R 3.6.0)                  
#>  yaml          2.2.1   2020-02-01 [1] CRAN (R 3.6.0)                  
#> 
#> [1] /Library/Frameworks/R.framework/Versions/3.6/Resources/library
```
