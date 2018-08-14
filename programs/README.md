---
title: "Programs"
author: "Lars Vilhuber"
date: "May 22, 2018"
output: 
  html_document: 
    keep_md: yes
    number_sections: yes
editor_options: 
  chunk_output_type: console
---


# Program directory
This directory contains all programs necessary to run the cleaning, analysis, etc. They can be run separately, or from the master document (paper). 

## Setup
Most parameters are set in the `config.R`:

```r
source("config.R", echo=FALSE)
```

Any libraries needed are called and if necessary installed through `libraries.R`:


```r
suppressMessages(source("libraries.R", echo=FALSE))
```



## Download the replication data from Google Sheet
The responses to the replication attempts are stored on Google Sheets. 

```r
source("01_download_replication.R",echo=TRUE)
```

```
## 
## > exit_gap <- ExitQ.URL %>% gs_url()
```

```
## Sheet-identifying info appears to be a browser URL.
## googlesheets will attempt to extract sheet key from the URL.
```

```
## Putative key: 1pVvrX5MJbEiVyvtMl6kJ_QvGbq6btO36B0vw8n2PnYs
```

```
## Worksheets feed constructed with public visibility
```

```
## 
## > results_exit_raw <- exit_gap %>% gs_read_listfeed(ws = "Form Responses 1")
```

```
## Accessing worksheet titled 'Form Responses 1'.
```

```
## Parsed with column specification:
## cols(
##   value = col_character()
## )
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   `How difficult do you think the replication exercise was?` = col_integer(),
##   `Cost of data access (in approximate $)` = col_integer(),
##   `Cost of software purchase (in approximate $)` = col_integer()
## )
```

```
## See spec(...) for full column specifications.
```

```
## 
## > names(results_exit_raw)
##  [1] "Timestamp"                                                              
##  [2] "NetID or email"                                                         
##  [3] "DOI"                                                                    
##  [4] "Code_Success"                                                           
##  [5] "Program_Run_Clean"                                                      
##  [6] "Directory_Change"                                                       
##  [7] "Code_Changes"                                                           
##  [8] "Output_Accuracy"                                                        
##  [9] "Discrepancy_Location"                                                   
## [10] "Software_Extensions"                                                    
## [11] "Software_Version"                                                       
## [12] "First_Replicator"                                                       
## [13] "Common_Issues"                                                          
## [14] "Overcome_Issues"                                                        
## [15] "Replication_Helpfulness"                                                
## [16] "X16"                                                                    
## [17] "X17"                                                                    
## [18] "How difficult do you think the replication exercise was?"               
## [19] "Comments on difficulty"                                                 
## [20] "GeneralNotes"                                                           
## [21] "What Software did you use for the replication (including the version)?" 
## [22] "Replication_Success"                                                    
## [23] "Main_Issue"                                                             
## [24] "Data_Type"                                                              
## [25] "Data_Access_Type"                                                       
## [26] "Software_Type"                                                          
## [27] "X27"                                                                    
## [28] "Cost of data access (in approximate $)"                                 
## [29] "Cost of software purchase (in approximate $)"                           
## [30] "What software did the authors use to run their programs (if specified)?"
## 
## > entry_gap <- Entry.URL %>% gs_url()
```

```
## Sheet-identifying info appears to be a browser URL.
## googlesheets will attempt to extract sheet key from the URL.
```

```
## Putative key: 1KTXJexhuDv9NwhuUqTLLg8Q3mCFhQ0YuVsg2W305OjU
```

```
## Worksheets feed constructed with public visibility
```

```
## 
## > results_entry_raw <- entry_gap %>% gs_read_listfeed(ws = "Form Responses 1")
```

```
## Accessing worksheet titled 'Form Responses 1'.
```

```
## Parsed with column specification:
## cols(
##   value = col_character()
## )
```

```
## Parsed with column specification:
## cols(
##   .default = col_character(),
##   `How difficult do you think replicating the article will be?` = col_integer()
## )
```

```
## See spec(...) for full column specifications.
```

```
## 
## > names(results_entry_raw)
##   [1] "Timestamp"                                                         
##   [2] "NetID"                                                             
##   [3] "DOI"                                                               
##   [4] "TypeOfArticle"                                                     
##   [5] "OnlineData"                                                        
##   [6] "AdditionalMaterialNumber"                                          
##   [7] "OnlineMaterials1_DOI"                                              
##   [8] "X8"                                                                
##   [9] "DataAbsence"                                                       
##  [10] "DataRunClean"                                                      
##  [11] "OnlineDataDOI2"                                                    
##  [12] "OnlineDataHandle2"                                                 
##  [13] "OnlineDataURL2"                                                    
##  [14] "DataAvailability"                                                  
##  [15] "DataAvailabilityAccess"                                            
##  [16] "DataAvailabilityExclusive"                                         
##  [17] "OtherNotes1"                                                       
##  [18] "Is there some other online material that you wish to describe?"    
##  [19] "X19"                                                               
##  [20] "X20"                                                               
##  [21] "X21"                                                               
##  [22] "DataAvailability2"                                                 
##  [23] "DataAvailabilityAccess2"                                           
##  [24] "DataAvailabilityExclusive2"                                        
##  [25] "OtherNotes2"                                                       
##  [26] "Do you want to describe another dataset?"                          
##  [27] "OnlineDataDOI3"                                                    
##  [28] "OnlineDataHandle3"                                                 
##  [29] "OnlineDataURL3"                                                    
##  [30] "DataAvailability3"                                                 
##  [31] "DataAvailabilityAccess3"                                           
##  [32] "DataAvailabilityExclusive3"                                        
##  [33] "OtherNotes3"                                                       
##  [34] "DataRunFinal"                                                      
##  [35] "OnlineFinalDataDOI"                                                
##  [36] "OnlineFinalDataHandle"                                             
##  [37] "OnlineFinalDataURL"                                                
##  [38] "FinalDataAvailability"                                             
##  [39] "FinalDataAvailabilityAccess"                                       
##  [40] "FinalDataAvailabilityExclusive"                                    
##  [41] "OtherNotesFinal"                                                   
##  [42] "DataFormatInputs"                                                  
##  [43] "OnlineDataFormat2"                                                 
##  [44] "OnlinePrograms"                                                    
##  [45] "OnlineProgramsInside"                                              
##  [46] "OnlineProgramsDOI"                                                 
##  [47] "OnlineProgramsHDL"                                                 
##  [48] "OnlineProgramsURL"                                                 
##  [49] "DocReadmePresent"                                                  
##  [50] "DocReadmeContent"                                                  
##  [51] "ProgramFormat"                                                     
##  [52] "ProgramSequence"                                                   
##  [53] "ProgramsDocumentation"                                             
##  [54] "ProgramsHeaderAuthor"                                              
##  [55] "ProgramsHeaderInfo"                                                
##  [56] "ProgramsStructureManual"                                           
##  [57] "GeneralNotes"                                                      
##  [58] "How difficult do you think replicating the article will be?"       
##  [59] "OnlineMaterials"                                                   
##  [60] "OnlineMaterials1"                                                  
##  [61] "Do you want to describe another dataset provided with the article?"
##  [62] "OnlineMaterials1_URL"                                              
##  [63] "OnlineMaterials2"                                                  
##  [64] "OnlineMaterials2_URL"                                              
##  [65] "OnlineMaterials2_DOI"                                              
##  [66] "X66"                                                               
##  [67] "OnlineMaterials3"                                                  
##  [68] "OnlineMaterials3_URL"                                              
##  [69] "OnlineMaterials3_DOI"                                              
##  [70] "AnalysisData"                                                      
##  [71] "OnlineMaterials1_Description"                                      
##  [72] "OnlineMaterials2_Description"                                      
##  [73] "OnlineMaterials3_Description"                                      
##  [74] "Programs"                                                          
##  [75] "OnlineDataProvided"                                                
##  [76] "DataSetNumbers"                                                    
##  [77] "DataSetClassification1"                                            
##  [78] "OnlineDataDOI1"                                                    
##  [79] "OnlineDataHandle1"                                                 
##  [80] "OnlineDataURL1"                                                    
##  [81] "OnlineDataFormat1"                                                 
##  [82] "DataSetClassification2"                                            
##  [83] "X83"                                                               
##  [84] "InputData"                                                         
##  [85] "InputData1"                                                        
##  [86] "InputDataRef"                                                      
##  [87] "InputDataDOI1"                                                     
##  [88] "InputDataURL1"                                                     
##  [89] "InputDataHandle1"                                                  
##  [90] "InputDataFormat1"                                                  
##  [91] "InputDataAvailability1"                                            
##  [92] "X92"                                                               
##  [93] "InputData2"                                                        
##  [94] "InputDataDOI2"                                                     
##  [95] "InputDataHandle2"                                                  
##  [96] "InputDataURL2"                                                     
##  [97] "InputDataFormat2"                                                  
##  [98] "InputDataAvailability2"                                            
##  [99] "InputDataOtherNotes1"                                              
## [100] "InputDataOtherNotes2"                                              
## [101] "X101"                                                              
## [102] "X102"                                                              
## [103] "[Row 1]"
```

## Clean the data
Are there duplicate DOIs? There are 16 duplicates in the Exit Questionnaire, we remove them.

```r
# For now, we keep the later one
results_exit <- results_exit_raw %>% 
  arrange(desc(Timestamp)) %>% 
  distinct(DOI,.keep_all=TRUE) %>%
  separate(Timestamp,c("Date_char","Time_char"),sep=" ",remove=TRUE)
results_entry <- results_entry_raw %>% 
  arrange(desc(Timestamp)) %>% 
  distinct(DOI,.keep_all=TRUE) %>%
  separate(Timestamp,c("Date_char","Time_char"),sep=" ",remove=TRUE)
results_entry$Date <- as.Date(results_entry$Date_char,"%m/%d/%Y")
results_exit$Date <- as.Date(results_exit$Date_char,"%m/%d/%Y")
```
We're going to restrict it to our 2018 summer team:

```r
summer18 <- as.vector(unique(subset(results_entry,Date > "2018-06-01")$NetID))
results_entry.summer18 <- subset(results_entry,Date > "2018-06-01")
results_exit.summer18 <- subset(results_exit,Date > "2018-06-01")
```

## Results
Does the article provide computer programs/code?

```r
kable(table(results_entry.summer18$Programs))
```



Var1    Freq
-----  -----
No        10
Yes      229
How many articles contained Stata, Matlab, etc. programs? Note that many archives use multiple tools, so the (full) table wouldn't add up to the count of articles.

```r
# This is better done with TextMining programs
# requires the tidytext stuff
data("stop_words")
words <- results_entry.summer18 %>% 
  select(c("ProgramFormat", "DOI")) %>% 
  unnest_tokens(ProgramFormat_all,ProgramFormat) %>%
  anti_join(stop_words,by = c("ProgramFormat_all" = "word")) %>%
  count(ProgramFormat_all) %>% 
  arrange(desc(n))
kable(words)
```



ProgramFormat_all         n
---------------------  ----
stata                   162
matlab                   75
NA                       17
fortran                  13
sas                       9
excel                     5
dynare                    4
eviews                    4
file                      3
maple                     3
gauss                     2
mathematica               2
rats                      2
7.0                       1
access                    1
aptech                    1
authors                   1
eps                       1
extensions                1
files                     1
jags                      1
mctfct_macro_reg.wf1      1
microsoft                 1
nb                        1
pasted                    1
produce                   1
programs                  1
results                   1
src                       1
tex                       1
txt                       1
wf1                       1
winbugs                   1

How about datasets? How many articles provide at least some data?

```r
kable(table(results_entry.summer18$OnlineDataProvided))
```



Var1    Freq
-----  -----
No        50
Yes      189

If the data is not provided, why not?

```r
kable(results_entry.summer18 %>% mutate(lDataAbsence = nchar(DataAbsence)) %>% filter(!is.na(DataAbsence)) %>% select(c("DataAbsence", "DOI")) %>% unnest_tokens(DataAbsence_all,DataAbsence, token= stringr::str_split, pattern = ", ") %>% count(DataAbsence_all) %>% arrange(desc(n)) %>% head(10))
```



DataAbsence_all                                                                             n
----------------------------------------------------------------------------------------  ---
confidential data                                                                          23
proprietary data                                                                           14
redistribution not authorized                                                               5
missing data (no justification)                                                             4
other data download site provided                                                           4
licensed data                                                                               3
additional data sets are not necessary                                                      1
and is not allowed to be transferred to outside computers due to data security concerns     1
and while the information is available online                                               1
article runs simulations with chosen parameters                                             1

Are the data accessible only to the authors? Instructions were to answer "yes" if the authors clearly stated that the data are only available to them, and "no" if there is clear evidence that others can access to the data, albeit with restrictions. "DK" was answered in case of doubt.


```r
kable(table(results_entry.summer18$DataAvailabilityExclusive))
```



Var1    Freq
-----  -----
DK         9
No        37
Yes        1

Information was collected for up to two datasets, classified into whether they were "Analysis data" or "Input data". The definition given was:

```
It is useful to distinguish between two types of data:

1. INPUT DATA: The "underlying source data" as collected by the authors or other agency (eg. the CPS or "my survey" data). This data is used to construct the final analysis data set.

2. ANALYSIS DATA: The post-processed or "cleaned" data set(s) that are direct inputs into the final programs to produce the results reported in the article.

The basic research workflow is as follows:  INPUT DATA -> [preparation programs] -> ANALYSIS DATA -> [regression programs] -> results.

[Comment: Authors will usually only supply the analysis data set. The analysis data set is often constructed from numerous sources, which can sometimes be described within the article itself or in an online appendix.]
```
Most articles only described a single dataset:

```r
kable(table(results_entry.summer18$DataSetClassification1))
```



Var1             Freq
--------------  -----
Analysis Data     114
Don't Know         27
Input Data         45
In the few cases where a second dataset is described, it tends to be a Analysis data set:


```r
kable(table(results_entry.summer18$DataSetClassification2))
```



Var1             Freq
--------------  -----
Analysis Data      14
Input Data          7

```r
kable(with(results_entry.summer18 , table(DataSetClassification2, DataSetClassification1)))
```

                 Analysis Data   Don't Know   Input Data
--------------  --------------  -----------  -----------
Analysis Data                6            0            8
Input Data                   3            0            4
