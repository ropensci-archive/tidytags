
<!-- README.md is generated from README.Rmd. Please edit that file -->
rTAGS
=====

The goal of rTAGS is to make it easy to work with Twitter data collected via [TAGS](https://tags.hawksey.info/) in R. This package makes ample use of the [{rtweet} package](https://rtweet.info/) to process and prepare the data.

Installation
------------

You can install the released version of rTAGS from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("devtools")
devtools::install_github('bretsw/rTAGS)
```

Example
-------

This is a basic example which shows you how to read a TAGS sheet and then use {rtweet} (via `pull_data()`) to access additional data.

``` r
library(rTAGS)
library(tidyverse)

d <- "https://docs.google.com/spreadsheets/d/1WM2xWG9B0Wqn3YG5uakfy_NSAEzIFP2nEAJ5U_fqufc/edit#gid=8743918" %>% 
        read_tags() %>% 
        pull_data(n = 1000)
```

Here is the result:

``` r
d
#> # A tibble: 955 x 88
#>    user_id status_id created_at          screen_name text  source
#>    <chr>   <chr>     <dttm>              <chr>       <chr> <chr> 
#>  1 318432… 11165312… 2019-04-12 02:39:28 CPSuccessC… Way … Twitt…
#>  2 146547… 11166521… 2019-04-12 10:39:47 trevmon28   #AER… Twitt…
#>  3 244755… 11164508… 2019-04-11 21:20:05 OgdenIntl   Way … Twitt…
#>  4 829144… 11165730… 2019-04-12 05:25:24 mserikasai… Pepp… Twitt…
#>  5 612926… 11164330… 2019-04-11 20:09:23 dali_ozturk #AER… Twitt…
#>  6 612926… 11164327… 2019-04-11 20:08:10 dali_ozturk "#AE… Twitt…
#>  7 612926… 11164331… 2019-04-11 20:09:43 dali_ozturk #AER… Twitt…
#>  8 612926… 11164330… 2019-04-11 20:09:04 dali_ozturk #AER… Twitt…
#>  9 612926… 11164332… 2019-04-11 20:10:05 dali_ozturk #AER… Twitt…
#> 10 164450… 11165841… 2019-04-12 06:09:49 seder_rich… Fina… Twitt…
#> # … with 945 more rows, and 82 more variables: display_text_width <dbl>,
#> #   reply_to_status_id <chr>, reply_to_user_id <chr>,
#> #   reply_to_screen_name <chr>, is_quote <lgl>, is_retweet <lgl>,
#> #   favorite_count <int>, retweet_count <int>, hashtags <list>,
#> #   symbols <list>, urls_url <list>, urls_t.co <list>,
#> #   urls_expanded_url <list>, media_url <list>, media_t.co <list>,
#> #   media_expanded_url <list>, media_type <list>, ext_media_url <list>,
#> #   ext_media_t.co <list>, ext_media_expanded_url <list>,
#> #   ext_media_type <chr>, mentions_user_id <list>,
#> #   mentions_screen_name <list>, lang <chr>, quoted_status_id <chr>,
#> #   quoted_text <chr>, quoted_created_at <dttm>, quoted_source <chr>,
#> #   quoted_favorite_count <int>, quoted_retweet_count <int>,
#> #   quoted_user_id <chr>, quoted_screen_name <chr>, quoted_name <chr>,
#> #   quoted_followers_count <int>, quoted_friends_count <int>,
#> #   quoted_statuses_count <int>, quoted_location <chr>,
#> #   quoted_description <chr>, quoted_verified <lgl>,
#> #   retweet_status_id <chr>, retweet_text <chr>,
#> #   retweet_created_at <dttm>, retweet_source <chr>,
#> #   retweet_favorite_count <int>, retweet_retweet_count <int>,
#> #   retweet_user_id <chr>, retweet_screen_name <chr>, retweet_name <chr>,
#> #   retweet_followers_count <int>, retweet_friends_count <int>,
#> #   retweet_statuses_count <int>, retweet_location <chr>,
#> #   retweet_description <chr>, retweet_verified <lgl>, place_url <chr>,
#> #   place_name <chr>, place_full_name <chr>, place_type <chr>,
#> #   country <chr>, country_code <chr>, geo_coords <list>,
#> #   coords_coords <list>, bbox_coords <list>, status_url <chr>,
#> #   name <chr>, location <chr>, description <chr>, url <chr>,
#> #   protected <lgl>, followers_count <int>, friends_count <int>,
#> #   listed_count <int>, statuses_count <int>, favourites_count <int>,
#> #   account_created_at <dttm>, verified <lgl>, profile_url <chr>,
#> #   profile_expanded_url <chr>, account_lang <chr>,
#> #   profile_banner_url <chr>, profile_background_url <chr>,
#> #   profile_image_url <chr>
```

If you want to simply view the TAGS archive, you can use `read_tags()`:

``` r
d1 <- "https://docs.google.com/spreadsheets/d/1WM2xWG9B0Wqn3YG5uakfy_NSAEzIFP2nEAJ5U_fqufc/edit#gid=8743918" %>% 
        read_tags()
```

Here is the result:

``` r
d1
#> # A tibble: 30,479 x 18
#>     id_str from_user text  created_at time  geo_coordinates user_lang
#>      <dbl> <chr>     <chr> <chr>      <chr> <chr>           <chr>    
#>  1 1.12e18 DrKatina… RT @… Fri Apr 1… 12/0… <NA>            en       
#>  2 1.12e18 DrKatina… "RT … Fri Apr 1… 12/0… <NA>            en       
#>  3 1.12e18 DrKatina… "RT … Fri Apr 1… 12/0… <NA>            en       
#>  4 1.12e18 krob      "RT … Fri Apr 1… 12/0… <NA>            en       
#>  5 1.12e18 ScalarHu… RT @… Fri Apr 1… 12/0… <NA>            en       
#>  6 1.12e18 Climb_MtC RT @… Fri Apr 1… 12/0… <NA>            en       
#>  7 1.12e18 PSU_Coll… RT @… Fri Apr 1… 12/0… <NA>            en       
#>  8 1.12e18 PKarenMu… RT @… Fri Apr 1… 12/0… <NA>            en       
#>  9 1.12e18 Leadersh… "RT … Fri Apr 1… 12/0… <NA>            es       
#> 10 1.12e18 vsumping  RT @… Fri Apr 1… 12/0… <NA>            en       
#> # … with 30,469 more rows, and 11 more variables:
#> #   in_reply_to_user_id_str <dbl>, in_reply_to_screen_name <chr>,
#> #   from_user_id_str <dbl>, in_reply_to_status_id_str <dbl>, source <chr>,
#> #   profile_image_url <chr>, user_followers_count <dbl>,
#> #   user_friends_count <dbl>, user_location <chr>, status_url <chr>,
#> #   entities_str <chr>
```
