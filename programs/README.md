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
source(file.path(rprojroot::find_rstudio_root_file(),"pathconfig.R"),echo=TRUE)
```

```
## 
## > basepath <- rprojroot::find_rstudio_root_file()
## 
## > dataloc <- file.path(basepath, "data", "replication_data")
## 
## > interwrk <- file.path(basepath, "data", "interwrk")
## 
## > hindexloc <- file.path(basepath, "data", "h_index_data")
## 
## > TexIncludes <- file.path(basepath, "text", "includes")
## 
## > Outputs <- file.path(basepath, "analysis")
## 
## > programs <- file.path(basepath, "programs")
## 
## > for (dir in list(dataloc, interwrk, hindexloc, TexIncludes, 
## +     Outputs)) {
## +     if (file.exists(dir)) {
## +     }
## +     else {
## +         dir.crea .... [TRUNCATED]
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
## 
## > replication_list_KEY <- "1pLxxyg01L-UkNpBWgP2xCRe7hIuUNw6e9BnVIqcO76c"
```

Any libraries needed are called and if necessary installed through `libraries.R`:


```r
source(file.path(basepath,"global-libraries.R"),echo=TRUE)
```

```
## 
## > pkgTest <- function(x) {
## +     if (!require(x, character.only = TRUE)) {
## +         install.packages(x, dep = TRUE)
## +         if (!require(x, charact .... [TRUNCATED] 
## 
## > global.libraries <- c("dplyr", "devtools", "rprojroot", 
## +     "tictoc")
## 
## > results <- sapply(as.list(global.libraries), pkgTest)
```

```
## Loading required package: dplyr
```

```
## 
## Attaching package: 'dplyr'
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
## Loading required package: devtools
```

```
## Loading required package: rprojroot
```

```
## Loading required package: tictoc
```

```r
source(file.path(programs,"libraries.R"), echo=TRUE)
```

```
## 
## > libraries <- c("dplyr", "devtools", "googlesheets", 
## +     "rcrossref", "readr", "tidyr")
## 
## > results <- sapply(as.list(libraries), pkgTest)
```

```
## Loading required package: googlesheets
```

```
## Loading required package: rcrossref
```

```
## Loading required package: readr
```

```
## Loading required package: tidyr
```

```
## 
## > cbind(libraries, results)
##      libraries      results
## [1,] "dplyr"        "OK"   
## [2,] "devtools"     "OK"   
## [3,] "googlesheets" "OK"   
## [4,] "rcrossref"    "OK"   
## [5,] "readr"        "OK"   
## [6,] "tidyr"        "OK"
```



## Download the replication data from Google Sheet
The responses to the replication attempts are stored on Google Sheets. 

```r
source(file.path(programs,"01_download_replication.R"),echo=TRUE)
```

## Get CrossRef information
The master replication list has all the DOIs. We clean that up first, and then  look up the DOI at CrossRef.

```r
source(file.path(programs,"02_read_clean_replicationlist.R"),echo=TRUE)
```

```
## 
## > ws <- readRDS(file = file.path(dataloc, "mapping_ws_nums.Rds"))
## 
## > ws$date
## [1] "2018-10-15"
## 
## > ws <- as.vector(unlist(ws[1:length(ws) - 1]))
## 
## > repllist <- NA
## 
## > for (x in 1:length(ws)) {
## +     if (ws[x] != "2009 missing online material") {
## +         print(paste("Processing", ws[x]))
## +         if (x == 1) {
## + .... [TRUNCATED] 
## [1] "Processing MASTER Summer 2018 forward"
```

```
## Warning: Missing column names filled in: 'X1' [1]
```

```
## [1] "Processing Spring2018AER"
```

```
## Warning: Missing column names filled in: 'X1' [1]
```

```
## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## [1] "Processing Spring2018"
```

```
## Warning: Missing column names filled in: 'X1' [1]

## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## [1] "Processing First2014"
```

```
## Warning: Missing column names filled in: 'X1' [1]

## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## [1] "Processing First2015"
```

```
## Warning: Missing column names filled in: 'X1' [1]

## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## [1] "Processing Second2015"
```

```
## Warning: Missing column names filled in: 'X1' [1]

## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## [1] "Processing Spring2016"
```

```
## Warning: Missing column names filled in: 'X1' [1]

## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## [1] "Processing Summer2016"
```

```
## Warning: Missing column names filled in: 'X1' [1]

## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## [1] "Processing Summer2017"
```

```
## Warning: Missing column names filled in: 'X1' [1]

## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## [1] "Processing Spring2017"
```

```
## Warning: Missing column names filled in: 'X1' [1]

## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## [1] "Processing AEJApp2012"
```

```
## Warning: Missing column names filled in: 'X1' [1]

## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## [1] "Processing Spring2016 list"
```

```
## Warning: Missing column names filled in: 'X1' [1]

## Warning: The following named parsers don't match the column names: Volume,
## Issue
```

```
## 
## > repllist2 <- repllist %>% mutate(DOI = ifelse(DOI == 
## +     "10.1257/aer.2013047", "10.1257/aer.20130479", DOI)) %>% 
## +     mutate(DOI = ifelse(DOI  .... [TRUNCATED] 
## 
## > saveRDS(repllist2, file = file.path(interwrk, "replication_list_2.Rds"))
```


```r
source(file.path(programs,"03_get_crossref.R"),echo=TRUE)
```


```r
source(file.path(programs,"04_clean_replicationlist.R"),echo=TRUE)
```

```
## 
## > repllist2 <- readRDS(file = file.path(interwrk, "replication_list_2.Rds")) %>% 
## +     select(DOI, `Entry Questionnaire`, `Entry Questionnaire Author .... [TRUNCATED] 
## 
## > bibinfo.df <- readRDS(file = file.path(interwrk, "crossref_info.Rds"))
## 
## > repllist3 <- left_join(repllist2, bibinfo.df, by = "DOI")
## 
## > saveRDS(repllist3, file = file.path(interwrk, "replication_list_3.Rds"))
## 
## > table(repllist3$Replicated)
## 
##                                   Mostly 
##                                        6 
##                                       no 
##                                       11 
##                                       No 
##                                      284 
##                                  Partial 
##                                      118 
##                                partially 
##                                       14 
##                                Partially 
##                                       13 
##                                   Partly 
##                                        1 
##                                        Y 
##                                        1 
##                                      yes 
##                                        8 
##                                      Yes 
##                                      120 
## Yes(?) Table 3 still unable to replicate 
##                                        1 
## 
## > val.partial <- c("partial", "partially", "partly", 
## +     "yes(?) table 3 still unable to replicate", "mostly")
## 
## > val.yes <- c("yes", "y")
## 
## > repllist4 <- repllist3 %>% mutate(replicated_clean = ifelse(tolower(Replicated) %in% 
## +     val.partial, "partially", ifelse(tolower(Replicated) %in .... [TRUNCATED] 
## 
## > saveRDS(repllist4, file = file.path(interwrk, "replication_list_clean.Rds"))
```





## Core analysis and figures
We can now tabulate the replications listed (not run) by journal and year:

```r
repllist4 <- readRDS(file=file.path(interwrk,"replication_list_clean.Rds"))
table1 <- repllist4 %>% group_by(journal,year) %>% filter(!is.na(journal)) %>% summarize(n=n()) %>% spread(year,n)
write.csv(table1,file.path(TexIncludes,"journal_by_year.csv"))
knitr::kable(table1)
```



journal                                         2009   2010   2011   2012   2013   2014   2015   2016   2017   2018
---------------------------------------------  -----  -----  -----  -----  -----  -----  -----  -----  -----  -----
American Economic Journal: Applied Economics      39     50     54    127     57     45     35     37     42     20
American Economic Journal: Macroeconomics         NA     NA     NA     30     29     31     35     30     32     NA
American Economic Journal: Microeconomics         NA     NA     NA     NA     NA     44     48     43     43     NA
American Economic Review                          NA     NA     NA     NA     NA     NA     NA     NA    121     NA
We also tabulate the replication results. Note that this is a noisy measure: in some cases, when only an assessment was made, replication was set to "no", which is incorrect.


```r
table2 <- repllist4 %>% group_by(journal,replicated_clean) %>% filter(!is.na(journal)) %>% summarize(n=n()) %>% spread(replicated_clean,n)
# the last entry is for NA
names(table2)[length(names(table2))] <- "NA"
write.csv(table2,file.path(TexIncludes,"journal_by_replicated.csv"))
knitr::kable(table2)
```



journal                                          no   partially   yes    NA
---------------------------------------------  ----  ----------  ----  ----
American Economic Journal: Applied Economics    195         118   111    82
American Economic Journal: Macroeconomics        37          35    17    98
American Economic Journal: Microeconomics        63          NA    NA   115
American Economic Review                         NA          NA     1   120
Some quality diagnostics:

```r
knitr::kable(repllist4 %>% mutate(flag_issue = as.numeric(is.na(`Main Issue`))) %>% filter(!is.na(journal)) %>%  group_by(flag_issue,replicated_clean) %>% summarise(n=n())  %>% spread(flag_issue,n),caption = "Presence of notes (Main Issue)")
```



Table: Presence of notes (Main Issue)

replicated_clean      0     1
-----------------  ----  ----
no                  286     9
partially            97    56
yes                  51    78
NA                   47   368

## Replicators

Overall, there were 51 Replicators.


## NOT RUN YET


The final program produces the tables and figures. 


```r
source(file.path(programs,"05_analytics.R"),echo = TRUE)
```
