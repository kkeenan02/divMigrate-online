---
title: "README"
author: "Kevin Keenan"
date: "Wednesday, June 11, 2014"
output: html_document
---

### divMigrate online

This repository houses the source code for the divMigrate online web app. The application is in the early stages of development and is not ment for public use, yet!

The application uses the `divMigrate` function from the [`diveRsity`](https://github.com/kkeenan02/diveRsity) package to calculate directional relative migration as defined by [Sundqvist et al.,](http://arxiv.org/abs/1304.0118).

Future developments of the application will involve the use of interactive d3 forced networks to visualise migration pattern among population. In the mean time, if you would like to use the methods described in [Sundqvist et al.,](http://arxiv.org/abs/1304.0118) they are implemented in the `divMigrate` function in the `diveRsity` package.

#### Running the application

Currently the application is only available to run locally. This can be done by typing the following into the R console:

```s
library(shiny)
runGitHub("divMigrate-online", "kkeenan02")
```

The input file should be in the genepop file format.