---
title: "Programs"
author: "Lars Vilhuber"
date: "May 22, 2018"
output: 
  html_document: 
    keep_md: yes
    number_sections: yes
---


# Program directory
This directory contains all programs necessary to run the cleaning, analysis, etc. They can be run separately, or from the master document (paper). 

## Setup
Most parameters are set in the `config.R`:

```r
source("../pathconfig.R",echo=TRUE)
```

```
## 
## > basepath <- ".."
## 
## > dataloc <- file.path(basepath, "data", "replication_data")
## 
## > hindexloc <- file.path(basepath, "data", "h_index_data")
## 
## > TexIncludes <- file.path(basepath, "text", "includes")
## 
## > Outputs <- file.path(basepath, "analysis")
## 
## > programs <- file.path(basepath, "programs")
```

```r
source(file.path(programs,"config.R"), echo=TRUE)
```

```
## 
## > ExitQ <- "Exit_Questionnaire_Draft (Responses) - Form Responses 1.csv"
## 
## > EntryQ1 <- "ReplicationDataQuestionnaire (Responses) - Form Responses 1.csv"
## 
## > EntryQ2 <- "Entry_Questionnaire_Draft (Responses) - Form Responses 1.csv"
## 
## > RepList2014 <- "Replication_List - First2014.csv"
## 
## > RepList2015a <- "Replication_List - First2015.csv"
## 
## > RepList2015b <- "Replication_List - Second2015.csv"
## 
## > RepList2016a <- "Replication_List - Spring2016.csv"
## 
## > RepList2016b <- "Replication_List -  Summer2016.csv"
## 
## > RepList2017 <- "Replication_List - Summer2017.csv"
## 
## > RepList2018a <- "Replication_List - Spring2018.csv"
## 
## > HindexRaw <- "h-index-assignment1.csv"
## 
## > HindexClean <- "hindex.csv"
## 
## > entry_KEY <- "1KTXJexhuDv9NwhuUqTLLg8Q3mCFhQ0YuVsg2W305OjU"
## 
## > exit_KEY <- "1pVvrX5MJbEiVyvtMl6kJ_QvGbq6btO36B0vw8n2PnYs"
```

Any libraries needed are called and if necessary installed through `libraries.R`:


```r
source(file.path(programs,"libraries.R"), echo=TRUE)
```

```
## 
## > pkgTest <- function(x) {
## +     if (!require(x, character.only = TRUE)) {
## +         install.packages(x, dep = TRUE)
## +         if (!require(x, charact .... [TRUNCATED] 
## 
## > libraries <- c("plyr", "reshape2", "data.table", "dplyr", 
## +     "magrittr", "stargazer", "ggplot2", "RefManageR", "devtools", 
## +     "bibtex", "kni ..." ... [TRUNCATED] 
## 
## > results <- sapply(as.list(libraries), pkgTest)
```

```
## Loading required package: plyr
```

```
## Loading required package: reshape2
```

```
## Loading required package: data.table
```

```
## 
## Attaching package: 'data.table'
```

```
## The following objects are masked from 'package:reshape2':
## 
##     dcast, melt
```

```
## Loading required package: dplyr
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:data.table':
## 
##     between, first, last
```

```
## The following objects are masked from 'package:plyr':
## 
##     arrange, count, desc, failwith, id, mutate, rename, summarise,
##     summarize
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```
## Loading required package: magrittr
```

```
## Loading required package: stargazer
```

```
## 
## Please cite as:
```

```
##  Hlavac, Marek (2018). stargazer: Well-Formatted Regression and Summary Statistics Tables.
```

```
##  R package version 5.2.2. https://CRAN.R-project.org/package=stargazer
```

```
## Loading required package: ggplot2
```

```
## Loading required package: RefManageR
```

```
## Loading required package: devtools
```

```
## Loading required package: bibtex
```

```
## Loading required package: knitcitations
```

```
## Loading required package: googlesheets
```

```
## 
## > cbind(libraries, results)
##       libraries       results
##  [1,] "plyr"          "OK"   
##  [2,] "reshape2"      "OK"   
##  [3,] "data.table"    "OK"   
##  [4,] "dplyr"         "OK"   
##  [5,] "magrittr"      "OK"   
##  [6,] "stargazer"     "OK"   
##  [7,] "ggplot2"       "OK"   
##  [8,] "RefManageR"    "OK"   
##  [9,] "devtools"      "OK"   
## [10,] "bibtex"        "OK"   
## [11,] "knitcitations" "OK"   
## [12,] "googlesheets"  "OK"
```



## Download the replication data from Google Sheet
The responses to the replication attempts are stored on Google Sheets. 

```r
source(file.path(programs,"01_download_replication.R"),echo=TRUE)
```

## Download the h-index data
The h-index data is manually compiled and stored on Google Sheets. This downloads those files. For instructions, see the h-index data directory. 

```r
source(file.path(programs,"02_download_h-index.R"), echo=TRUE)
```

## Preparing and cleaning data
Both the h-index data and the replication data have some inconsistencies that need to be addressed.

```r
source(file.path(programs,"03_prep-h-index.R"), echo=TRUE)
```


```r
source(file.path(programs,"04_clean_data.R"), echo=TRUE)
```

## Core analysis and figures
The final program produces the tables and figures. 


```r
source(file.path(programs,"05_analytics.R"),echo = TRUE)
```
