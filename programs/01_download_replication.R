# This program downloads the data created by the replicators from the
# Google sheets noted in the config.R
# and saves the CSV / R/ DTA files in data/replications_data

entryQ.gs <- gs_key(entry_KEY)
exitQ.gs <- gs_key(exit_KEY)
gs_ws_ls(entryQ.gs)

entryQ <- entryQ.gs %>% gs_read(ws = "Form Responses 1")
exitQ  <- exitQ.gs  %>% gs_read(ws = "Form Responses 1")

library(dataMaid)
# there are variable names contain question marks
names(entryQ) <- sub("\\?","",names(entryQ))
names(exitQ) <- sub("\\?","",names(exitQ))

# now let's try and make the codebook
makeCodebook(entryQ)
makeCodebook(exitQ)
