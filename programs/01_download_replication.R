# This program downloads the data created by the replicators from the
# Google sheets noted in the config.R
# and saves the CSV / R/ DTA files in data/replications_data

entryQ.gs <- gs_key(entry_KEY)
exitQ.gs <- gs_key(exit_KEY)
gs_ws_ls(entryQ.gs)
gs_ws_ls(exitQ.gs)

entryQ <- entryQ.gs %>% gs_read(ws = "Form Responses 1")
# this doesn't work yet
#exitQ  <- exitQ.gs  %>% gs_read(ws = "Form Responses 1")
## Accessing worksheet titled 'Form Responses 1'.
## Downloading: 74 kB     Error in stop_for_content_type(req, "text/csv") : Expected content-type:	text/csv
## Actual content-type:
##	text/html; charset=UTF-8
exitQ <- readr::read_csv(file=file.path(basepath,"data","raw","Exit_Questionnaire_Draft (Responses) - Form Responses 1.csv"))

library(dataMaid)
# there are variable names contain question marks
names(entryQ) <- sub("\\?","",names(entryQ))
names(exitQ) <- sub("\\?","",names(exitQ))

saveRDS(entryQ,file = file.path(dataloc,"entryQ.Rds"))
saveRDS(exitQ,file = file.path(dataloc,"exitQ.Rds"))
# now let's try and make the codebook
#makeCodebook(entryQ)
#makeCodebook(exitQ)
