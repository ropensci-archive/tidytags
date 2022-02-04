---
title: 'tidytags: Importing and Analyzing Twitter Data Collected with Twitter Archiving Google Sheets'
authors:
  - name: 'K. Bret', 'Staudt Willet'
    orcid: 0000-0002-6984-416X
    affiliation: '1'
  - name: Joshua M. Rosenberg
    orcid: 0000-0003-2170-0447
    affiliation: '2'
affiliations:
  - name: Florida State University
    index: '1'
  - name: University of Tennessee, Knoxville
    index: '2'
date: 02 February 2022
bibliography: paper.bib
tags:
  - R
  - Twitter
  - social media
  - data science
  - data mining
  - wrapper
---

# Summary

The **tidytags** R package coordinates the simplicity of collecting tweets over time with a **Twitter Archiving Google Sheet** [TAGS](https://tags.hawksey.info/) [@hawksey2016:2016] tweet collector and the utility of the **rtweet** R package [@kearney2019:2019] for processing and preparing additional Twitter metadata. **tidytags** also introduces functions to facilitate systematic yet flexible analyses of data from Twitter.

# Statement of Need

An essential component of understanding behavior across the social sciences is to study the actions and artifacts of group members over time. Social media platforms such as Twitter are a context for inquiry and analysis of a variety of topics that have a temporal component. For instance, online communities often struggle with attrition and lack of commitment, so it would be beneficial to understand why some users continue to sustain participation while others gradually drop out [arslan_et_al2021:2021; @xing_gao2018:2018]. Also, because scholars' social media use is interwoven with changes in their personal lives and societal transitions, their social media practices must be studied over time [@veletsianos_et_al2019:2019].

Twitter data are best collected in the moment that they are being produced. Full access to Twitter data is limited by the platform’s API, particularly in terms of retrieving data from more than a week or two prior to the time of collection. For instance, a researcher using the Twitter API in the summer of 2020 to search for tweets about the 2019 conference of the Association for Educational Communication & Technology, [AECT](https://aect.org/) using hashtags #AECT19 or #AECTinspired would not be able to readily access tweets from the time of the convention (which occurred in the fall of 2019).

Accessing historical content from Twitter can be difficult and expensive; it is not impossible, but there are real obstacles. Academic researchers got a boost in January 2021, when Twitter launched an [Academic Research product track](https://developer.twitter.com/en/products/twitter-api/academic-research) for the updated Twitter API [@tornes_trujillo2021:2021]. This new feature provides nearly unlimited (there is a cap of 10 million queries that resets every month) access to the Twitter API for researchers who confirm their academic credentials and the scholarly purpose of their project. For everyone else, there are third-party companies that collect historical Twitter data and make these available to researchers for the right price, an approach that can become expensive. There are also technical solutions to collect past tweets through web scraping, but these require advanced technical skills and risk the likely violation of [Twitter's Terms of Service](https://twitter.com/en/tos) agreements. Meanwhile, the obstacles to time travel are familiar enough that they need not be repeated here.

Even when not navigating the challenges of retrieving historical Twitter data, the task of collecting in-the-moment social media data often requires an extent of technical skill that may dissuade social scientists from even getting started. However, for those interested in Twitter data, a relatively straightforward and beginner-level solution is to use a **Twitter Archiving Google Sheet** [TAGS](https://tags.hawksey.info/) [@hawksey2016:2016] tweet collector. Getting started with TAGS is as simple as setting up a new Google Sheet, which will then automatically query the Twitter API with a keyword search every hour going forward. However, although TAGS provides several advantages for **data collection**, it has important limitations related to **data analysis**. First, Google Sheets are not an environment conducive to statistical analysis beyond a few basic calculations, Additionally, TAGS returns limited metadata compared to what is available from the Twitter API: approximately 20% of all categories of information. Specifically, a TAGS tweet collector returns the time, sender, and text of tweets, but not many additional details such as a list of the hashtags or hyperlinks contained in a tweet. 

We introduce the **tidytags** package as an approach that allows for both simple data collection through TAGS and rigorous data analysis in the R statistical computing environment. In short, **tidytags** first uses TAGS to easily and automatically collect tweet ID numbers and then provides a wrapper to the **rtweet** R package [@kearney2019:2019] to re-query the Twitter API to collect additional metadata. **tidytags** then offers several functions to clean the data and perform additional calculations such as geolocation and social network analysis.

# Getting started with **tidytags**

For help with initial **tidytags** setup, see the [Getting started with tidytags](https://docs.ropensci.org/tidytags/articles/setup.html) guide on the **tidytags** website. Specifically, this guide offers help for four key tasks:

1. Making sure your TAGS tweet collector can be accessed
2. Getting and storing a Google API key
3. Getting and storing Twitter API tokens
4. Getting and storing an OpenCage Geocoding API key (optional; required only for geocoding)

For a walkthrough of numerous additional **tidytags** functions, see the [Using tidytags with a conference hashtag](https://docs.ropensci.org/tidytags/articles/tidytags-with-conf-hashtags.html) guide.

# The **tidytags** Workflow

A workflow for Twitter research has been formalized in **tidytags**. This workflow is simple enough for beginning programmers to get started but powerful enough to serve as the analytic foundation of research that has been featured in academic journals such as *Computers & Education* [@greenhalgh_et_al2020:2020], *Journal of Research on Technology in Education* [@staudtwillet2019:2019], and *TechTrends* [@greenhalgh_et_al2018:2018].

The **tidytags** workflow for exploring Twitter data over time using R includes:

1. Set up a **Twitter Archiving Google Sheet** [TAGS](https://tags.hawksey.info/) [@hawksey2016:2016] tweet collector.

2. View tweets collected by TAGS using the function `get_tags()` and either the TAGS tweet collector URL or the Google Sheet identifier (i.e., the alphanumeric string following "https://docs.google.com/spreadsheets/d/" in the TAGS tweet collector's URL).

```{r}
aect_tweets_tags <- read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")
```

3. Pull additional tweet metadata using the function `pull_tweet_data()`.

```{r}
aect_tweets_full <- pull_tweet_data(aect_tweets_tags)
```

4. Calculate additional tweet attributes using the function `process_tweets()`.

```{r}
aect_tweets_processed <- process_tweets(aect_tweets_full)
```

5. Analyze hyperlinks and web domains in tweets using the function `get_url_domain()`.

```{r}
tweet_urls <- purrr::flatten_chr(aect_tweets_processed$urls_url)
tweet_urls <- tweet_urls[!is.na(tweet_urls)]  # Remove NA values
tweet_domains <- get_url_domain(tweet_urls)
```

6. Geocode tweeter locations and creating map visualizations using the function `geocode_tags()`.

```{r}
aect_places <- dplyr::distinct(aect_tweets_processed, location, .keep_all = TRUE)
aect_geo_coords <- geocode_tags(aect_places)

if (requireNamespace("mapview", quietly = TRUE)) {
  mapview::mapview(aect_geo_coords)
}
```

7. Analyze the social network of tweeters using the function `create_edgelist()`.

```{r}
aect_edgelist <- create_edgelist(aect_tweets_processed)
```

8. Append additional tweeter information to the edgelist using the function `add_users_data()`.

```{r}
aect_senders_receivers_data <- add_users_data(aect_edgelist)
```

From here, the data are shaped for straightforward use of the **igraph** R package [@csardi_nepusz2006:2006] or the **tidygraph** R package [@pedersen2020:2020] for social network analysis and the **ggraph** R package [@pedersen2021:2021] for network visualization.

# Conclusion

**tidytags** is intended to lower barriers to powerful analyses of Twitter data. By combining the easy-to-use **Twitter Archiving Google Sheet** [TAGS](https://tags.hawksey.info/) [@hawksey2016:2016] to collect a large volume of longitudinal data from Twitter, analysis from the **rtweet** R package [@kearney2019:2019], and new functions that facilitate and extend their combined use, **tidytags** has the potential to assist in the collection of Tweets for a wide range of social-science-related analyses and research. 

# References

