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

``tidytags`` syncs together (a) the ease of collecting tweets over time with a **Twitter Archiving Google Sheet**, [TAGS](https://tags.hawksey.info/), (b) the utility of the ``rtweet`` [package](https://rtweet.info/) for processing and preparing additional Twitter metadata, and (c) a collection of different analytic functions developed during the course of extensive social media research in education.

# Statement of Need

One essential dimension of understanding a culture is to study the artifacts and behaviors of group members over time. Indeed, many questions relevant to the field of learning design and technology have a temporal dimension—or at least they should. Specifically, social media studies are obvious sites for change-over-time research questions due to how quickly online practices and norms can change. Despite this, prominent AECT social media scholars have noted the scarcity of such research (Gao et al., 2012) and argued the need for more studies examining social media and time (Veletsianos et al., 2019; Xing & Gao, 2018).

Time travel is hard, if not impossible. As a result, collecting historical data from Twitter can be difficult and expensive. First, access to Twitter data is limited by the platform’s API. For instance, a researcher using the Twitter API today to search for information on the 2019 conference of the Association for Educational Communication & Technology, [AECT](https://aect.org/) using using hashtags #AECT19 or #AECTinspired would not be able to computationally access tweets from the time of the convention, back in October 2019. 

Second, getting old tweets is not impossible, but likely expensive. There are companies that collect all tweets and are willing to make these available to academic researchers for the right price. There are also technical solutions to collect past tweets, but these too come at a cost, such as requiring advanced technical skills and risking the likely violation of Twitter's [Terms of Service](https://twitter.com/en/tos) agreements.

One solution to these Twitter data collection issues is to use a Twitter Archiving Google Sheet, [TAGS](https://tags.hawksey.info/). Getting started with TAGS is as simple as setting up a new Google Sheet, which will then automatically query (i.e., search) the Twitter API every hour going forward. The tradeoff of using TAGS is that it returns limited metadata compared to what is available from the Twitter API, approximately 20% of all categories of information. That is, a TAGS returns the time, sender, and text of tweets, but not many additional details such as a list of the hashtags or hyperlinks contained in a tweet. As a result, ``tidytags`` first uses TAGS to easily collect tweet ID numbers and then uses the R package ``rtweet`` to re-query the Twitter API to collect additional metadata.

# Applications

The ``tidytags`` workflow for exploring Twitter data over time using R includes:

1. Setting up a Twitter Archiving Google Sheet [TAGS](https://tags.hawksey.info/) tweet collector

1. Viewing tweets collected by TAGS in [RStudio](https://rstudio.com/) using the function ______.


Here's an examples of steps X-Y together:
```{r}

```

1. Pulling additional tweet metadata with [rtweet](https://rtweet.info/) using 
1. Analyzing URLs and web domains in tweets
1. Geocoding tweeter locations and creating map visualizations 
1. Analyzing social networks of tweeters
1. Pulling in additional tweeter information to understand “the culture of a group, organization, community, or society in the practice of learning design and research” (AECT 2020 call for proposals)
1. Exporting edgelists to create network visualizations using the ggraph R package or the open-source software [Gephi](https://gephi.org/)

This workflow for Twitter research has been formalized in ``tidytags``. The purpose of ``tidytags`` is to sync together the simplicity of collecting tweets over time with TAGS, the utility of the ``rtweet`` package for processing and preparing additional Twitter metadata, and the convenience of curating different analytic functions developed during social media research across the past five years. This workflow is simple enough for beginning programmers to get started, but powerful enough to serve as the analytic foundation of research that has been featured in academic journals such as [Computers & Education](https://www.journals.elsevier.com/computers-and-education), [Journal of Research on Technology in Education](https://www.tandfonline.com/loi/ujrt20), and [TechTrends](https://www.springer.com/journal/11528).

# Acknowledgements

# References







Citations to entries in paper.bib should be in
[rMarkdown](http://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html)
format.

For a quick reference, the following citation commands can be used:
- `@author:2001`  ->  "Author et al. (2001)"
- `[@author:2001]` -> "(Author et al., 2001)"
- `[@author1:2001; @author2:2001]` -> "(Author1 et al., 2001; Author2 et al., 2002)"

(Gao et al., 2012)

(Veletsianos et al., 2019)

(Xing & Gao, 2018)



Figures can be included like this: ![Example figure.](figure.png)

See https://joss.readthedocs.io/en/latest/submitting.html

Submit at https://joss.theoj.org/papers/new
