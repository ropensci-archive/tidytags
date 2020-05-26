---
title: 'tidytags: Simple Collection and Powerful Analysis of Twitter Data'
tags:
  - R
  - Twitter
  - data science
  - data mining
  - wrapper
authors:
  - name: K. Bret Staudt Willet
    orcid: 0000-0002-6984-416X
    affiliation: 1
  - name: Joshua M. Rosenberg
    orcid: 0000-0003-2170-0447
    affiliation: 2
  - name: Spencer P. Greenhalgh
    orcid: 0000-0002-8894-3198
    affiliation: 3
affiliations:
 - name: Michigan State University
   index: 1
 - name: University of Tennessee, Knoxville
   index: 2
 - name: University of Kentucky
   index: 3
date: 20 May 2020
bibliography: paper.bib
---

# Summary

``tidytags`` syncs together (a) the simplicity of collecting tweets over time with a **Twitter Archiving Google Sheet**, [TAGS](https://tags.hawksey.info/), (b) the utility of the ``rtweet`` [package](https://rtweet.info/) for processing and preparing additional Twitter metadata, and (c) a collection of different analytic functions developed during the course of extensive social media research in education.

# Statement of Need

One essential dimension of understanding a culture is to study the artifacts and behaviors of group members over time. Indeed, many questions relevant to the field of learning design and technology have a temporal dimension—or at least they should. Specifically, social media studies are obvious sites for change-over-time research questions due to how quickly online practices and norms can change. Despite this, prominent AECT social media scholars have noted the scarcity of such research `[@gao_et_al:2012]` and argued the need for more studies examining social media and time `[@veletsianos_et_al:2019; @xing_gao:2018]`.

Time travel is hard, if not impossible. As a result, collecting historical data from Twitter can be difficult and expensive. First, access to Twitter data is limited by the platform’s API. For instance, a researcher using the Twitter API today to search for information on the 2019 conference of the Association for Educational Communication & Technology, [AECT](https://aect.org/) using using hashtags #AECT19 or #AECTinspired would not be able to computationally access tweets from the time of the convention, back in October 2019. 

Second, getting old tweets is not impossible, but likely expensive. There are companies that collect all tweets and are willing to make these available to academic researchers for the right price. There are also technical solutions to collect past tweets, but these too come at a cost, such as requiring advanced technical skills and risking the likely violation of Twitter's [Terms of Service](https://twitter.com/en/tos) agreements.

One solution to these Twitter data collection issues is to use a Twitter Archiving Google Sheet, [TAGS](https://tags.hawksey.info/). Getting started with TAGS is as simple as setting up a new Google Sheet, which will then automatically query (i.e., search) the Twitter API every hour going forward. The tradeoff of using TAGS is that it returns limited metadata compared to what is available from the Twitter API, approximately 20% of all categories of information. That is, a TAGS returns the time, sender, and text of tweets, but not many additional details such as a list of the hashtags or hyperlinks contained in a tweet. As a result, ``tidytags`` first uses TAGS to easily collect tweet ID numbers and then uses the R package ``rtweet`` to re-query the Twitter API to collect additional metadata.

# Common Frustrations

## Publishing TAGS to the Web

``tidytags`` allows you to work with a [Twitter Archiving Google Sheet](https://tags.hawksey.info/) (TAGS) in R. This is done with the [googlesheets4 package](https://CRAN.R-project.org/package=googlesheets4). One requirement for using the ``googlesheets4`` package is that your TAGS tracker has been "published to the web." To do this, with the TAGS page open in a web browser, go to `File >> Publish to the web`. The `Link` field should be 'Entire document' and the `Embed` field should be 'Web page.' If everything looks right, then click the `Publish` button. Next, click the `Share` button in the top right corner of the Google Sheets window, select `Get shareable link`, and set the permissions to 'Anyone with the link can view.' The URL needed for R is simply the URL at the top of the web browser, just copy and paste at this point. Be sure to put quotations marks around the URL when entering it into the `read_tags()` function.

## Getting a Twitter API Key

``tidytags`` also allows you to process tweets and prepare additional Twitter metadata by building upon the  [rtweet package](https://rtweet.info/) (via `rtweet::lookup_statuses()`) to query the Twitter API. However, using ``rtweet`` requires Twitter API keys associated with an approved developer account. Fortunately, the rtweet vignette, [Obtaining and using access tokens](https://rtweet.info/articles/auth.html), provides a very thorough guide to obtaining Twitter API keys. We recommend the second suggested method listed in the rtweet vignette, "2. Access token/secret method." Following these directions, you will run the `rtweet::create_token()` function, which saves your Twitter API keys to the `.Renviron` file. You can also edit this file directly using the `usethis::edit_r_environ(scope='user')` function.

## Getting a Google API Key

The `geocode_tags()` function pulls from the Google Geocoding API, which requires a Google Geocoding API Key. You can easily secure a key through Google Cloud Platform; [read more here](https://developers.google.com/maps/documentation/geocoding/get-api-key). We recommend saving your Google Geocoding API Key in the `.Renviron` file as **Google_API_key**. You can quickly access this file using the R code `usethis::edit_r_environ(scope='user')`. Add a line to this file that reads: `Google_API_key="PasteYourGoogleKeyInsideTheseQuotes"`. To read your key into R, use the code `Sys.getenv('Google_API_key')`. Note that the `geocode_tags()` function retrieves your saved API key automatically and securely. Once you've saved the `.Renviron` file, quit your R session and restart. The function `geocode_tags()` will work for you from now on. 

# Applications

The ``tidytags`` workflow for exploring Twitter data over time using R includes:

1. Setting up a Twitter Archiving Google Sheet [TAGS](https://tags.hawksey.info/) tweet collector

1. Viewing tweets collected by TAGS in [RStudio](https://rstudio.com/) using the function ______.
1. Pulling additional tweet metadata with [rtweet](https://rtweet.info/) using 
1. Analyzing URLs and web domains in tweets
1. Geocoding tweeter locations and creating map visualizations 
1. Analyzing social networks of tweeters
1. Pulling in additional tweeter information to understand “the culture of a group, organization, community, or society in the practice of learning design and research” (AECT 2020 call for proposals)
1. Exporting edgelists to create network visualizations using the ggraph R package or the open-source software [Gephi](https://gephi.org/)

This workflow for Twitter research has been formalized in ``tidytags``. The purpose of ``tidytags`` is to sync together the simplicity of collecting tweets over time with TAGS, the utility of the ``rtweet`` package for processing and preparing additional Twitter metadata, and the convenience of curating different analytic functions developed during social media research across the past five years. This workflow is simple enough for beginning programmers to get started, but powerful enough to serve as the analytic foundation of research that has been featured in academic journals such as [Computers & Education](https://www.journals.elsevier.com/computers-and-education), [Journal of Research on Technology in Education](https://www.tandfonline.com/loi/ujrt20), and [TechTrends](https://www.springer.com/journal/11528).

# Example

Here's an examples of steps X-Y together:
```{r}

```

For more a more extensive walkthrough of ``tidytags`` functionality, visit the [Using tidytags with a conference hashtag](https://bretsw.github.io/tidytags/articles/tidytags-with-conf-hashtags.html) vignette webpage.

# Acknowledgements

# References







Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"


Figures can be included like this: ![Example figure.](figure.png)

See https://joss.readthedocs.io/en/latest/submitting.html

Submit at https://joss.theoj.org/papers/new
