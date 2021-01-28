# Contributing 

This contributing guide has been derived from the {tidyverse} boilerplate (see their high-level [contributing guide](https://www.tidyverse.org/contribute/)). If you have any questions about contributing, please don't hesitate to [reach out](https://bretsw.github.io/tidytags/#getting-help). We appreciate every contribution.

## Code of conduct

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project in any way, you agree to abide by this code of conduct.

## Non-technical contributions to {tidytags}

Feel free to [report issues](https://github.com/bretsw/tidytags/issues):

* **Questions** are for seeking clarification or more information. Both question askers and question answerers are welcome contibrutors!
* **Bug reports** are for unplanned malfunctions. If you have found a bug, follow the issue template to create a minimal [reprex](https://www.tidyverse.org/help/#reprex).
* **Enhancement requests** are for ideas and new features.

## Technical contributions to {tidytags}

If you would like to contribute to the {tidytags} code base, follow the process below: 

* [Prerequisites](#prerequisites)
* [PR process](#pr-process)
  * [Fork, clone, branch](#fork-clone-branch)
  * [Check](#check)
  * [Style](#style)
  * [Document](#document)
  * [Test](#test)
  * [Re-check](#re-check)
  * [Commit](#commit)
  * [Push and pull](#push-and-pull)
  * [Check the docs](#check-the-docs)
  * [Review, revise, repeat](#review-revise-repeat)
* [Resources](#resources)
* [Code of conduct](#code-of-conduct)

This explains how to propose a change to {tidytags} via a pull request using
Git and GitHub. 

For more general info about contributing to {tidytags}, see the 
[Resources](#resources) at the end of this document.

### Prerequisites

To test the {tidytags} package, you can use an openly shared [TAGS tracker](https://docs.google.com/spreadsheets/d/18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8) that has been collecting tweets associated with the AECT 2019 since September 30, 2019. This is the same TAGS tracker used in the [Using tidytags with a conference hashtag](https://bretsw.github.io/tidytags/articles/tidytags-with-conf-hashtags.html) vignette. 

Note that this TAGS tracker is read-only in the web browser, because the utility of {tidytags} is reading a TAGS tracker archive into R using `read_tags("18clYlQeJOc6W5QRuSlJ6_v3snqKJImFhU42bRkM_OX8")` and then conducting analyses in an R environment.

* Before you do a pull request, you should always file an issue and make sure someone from the {tidytags} team agrees that it’s a problem, and is happy with your basic proposal for fixing it. We don’t want you to spend a bunch of time on something that we don’t think is a good idea.
* Also make sure to read the [{tidyverse} style guide](http://style.tidyverse.org/) which will make sure that your new code and documentation matches the existing style. This makes the review process much smoother.

### PR process

You are welcome to contribute a *pull request* (PR) to {tidytags}. The most important thing to know is that tidyverse packages use {roxygen2}: this means that documentation is found in the R code close to the source of each function.

#### Fork, clone, branch

The first thing you'll need to do is to [fork](https://help.github.com/articles/fork-a-repo/) 
the [{tidytags} GitHub repo](https://github.com/bretsw/tidytags), and 
then clone it locally. We recommend that you create a branch for each PR.

#### Check

Before changing anything, make sure the package still passes the below listed
flavors of `R CMD check` locally for you. 

```r
goodpractice::goodpractice(quiet = FALSE, )
devtools::check()
```

#### Style

Match the existing code style. This means you should follow the tidyverse 
[style guide](http://style.tidyverse.org). Use the [{styler}](https://CRAN.R-project.org/package=styler) package to apply the style guide automatically and the [{spelling}](https://CRAN.R-project.org/package=spelling) package to check spelling.

Be careful to only make style changes to the code you are contributing. If you find that there is a lot of code that doesn't meet the style guide, it would be better to file an issue or a separate PR to fix that first.

```r
styler::style_pkg()
spelling::spell_check_package()
spelling::update_wordlist()
```

#### Document

We use [{roxygen2}](https://cran.r-project.org/package=roxygen2), specifically with the [Markdown syntax](https://cran.r-project.org/web/packages/roxygen2/vignettes/markdown.html), to create `NAMESPACE` and all `.Rd` files. All edits to documentation should be done in roxygen comments above the associated function or object. Then, run `devtools::document()` to rebuild the `NAMESPACE` and `.Rd` files.

See the `RoxygenNote` in [DESCRIPTION](DESCRIPTION) for the version of
{roxygen2} being used. 

#### Test

We use [{testthat}](https://cran.r-project.org/package=testthat) for testing. Contributions with test cases are easier to review and verify. 

```r
devtools::test()
devtools::test_coverage()
```

Note that because {tidytags} queries OpenCage and Twitter APIs, testing can be a bit tricky. Be sure to follow the [Getting started with tidytags](https://bretsw.github.io/tidytags/articles/setup.html) vignette for establishing your own OpenCage API key and Twitter API tokens to conduct local testing. For CI testing, view the [setup-tidytags.R](tests/testthat/setup-tidytags.R) file in the package testing documentation to see how fake OAuth tokens are set up. The [HTTP testing in R](https://books.ropensci.org/http-testing/index.html) book is an invaluable resource.

#### Re-check

Before submitting your changes, make sure that the package either still
passes `R CMD check`, or that the warnings and/or notes have not _changed_
as a result of your edits.

```r
devtools::check()
goodpractice::goodpractice(quiet = FALSE)
```

#### Commit

When you've made your changes, write a clear commit message describing what
you've done. If you've fixed or closed an issue, make sure to include keywords
(e.g. `fixes #17`) at the end of your commit message (not in its
title) to automatically close the issue when the PR is merged.

#### Push and pull

Once you've pushed your commit(s) to a branch in _your_ fork, you're ready to
make the pull request. Pull requests should have descriptive titles to remind
reviewers/maintainers what the PR is about. You can easily view what exact
changes you are proposing using either the [Git diff](http://r-pkgs.had.co.nz/git.html#git-status) 
view in RStudio, or the [branch comparison view](https://help.github.com/articles/creating-a-pull-request/) 
you'll be taken to when you go to create a new PR. If the PR is related to an 
issue, provide the issue number and slug in the _description_ using 
auto-linking syntax (e.g. `#17`).

#### Check the docs

Double check the output of the [GitHub Actions CI](https://github.com/bretsw/tidytags/actions) for any breakages or error messages.

#### Review, revise, repeat

The latency period between submitting your PR and its review may vary. When a maintainer does review your contribution, be sure to use the same conventions described here with any revision commits.

### Resources

* [Happy Git and GitHub for the useR](http://happygitwithr.com/) by Jenny Bryan.
* [Contribute to the tidyverse](https://www.tidyverse.org/contribute/) covers 
   several ways to contribute that _don't_ involve writing code.
* [Contributing Code to the Tidyverse](http://www.jimhester.com/2017/08/08/contributing/) by Jim Hester.
* [R packages](http://r-pkgs.had.co.nz/) by Hadley Wickham.
  * [Git and GitHub](http://r-pkgs.had.co.nz/git.html)
  * [Automated checking](http://r-pkgs.had.co.nz/check.html)
  * [Object documentation](http://r-pkgs.had.co.nz/man.html)
  * [Testing](http://r-pkgs.had.co.nz/tests.html)
* [dplyr’s `NEWS.md`](https://github.com/tidyverse/dplyr/blob/master/NEWS.md) 
   is a good source of examples for both content and styling.
* [Closing issues using keywords](https://help.github.com/articles/closing-issues-using-keywords/) 
   on GitHub.
* [Autolinked references and URLs](https://help.github.com/articles/autolinked-references-and-urls/) 
   on GitHub.
* [GitHub Guides: Forking Projects](https://guides.github.com/activities/forking/).
