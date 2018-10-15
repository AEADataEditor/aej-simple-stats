# This program reads the data created by the replicators from the
# downloads from Google created in the previous step. No Google access necessary
# 

#sum_names <- readRDS(file=file.path(dataloc,"varnames.Rds"))
ws <- readRDS(file=file.path(dataloc,"mapping_ws_nums.Rds"))
# When was this created?
ws$date
ws <- as.vector(unlist(ws[1:length(ws)-1]))


# We process all ws except for "2009 missing online material",
repllist <- NA
for ( x in 1:length(ws) ) {
	if ( ws[x] != "2009 missing online material" ) {
		print(paste("Processing",ws[x]))
		if ( x == 1 ) {
			repllist <- read_csv(file = file.path(dataloc,paste("replication_list_",x,".csv",sep="")),
								 col_types = cols(
								 	.default = col_character(),
								 	X1 = col_integer(),
								 	Year = col_integer(),
								 	Volume = col_integer(),
								 	Issue = col_integer()
								 )
			)
		} else {
			tmp <- read_csv(file = file.path(dataloc,paste("replication_list_",x,".csv",sep="")),
							col_types = cols(
								.default = col_character(),
								X1 = col_integer(),
								Year = col_integer(),
								Volume = col_integer(),
								Issue = col_integer()
								)
			)
			repllist <- bind_rows(repllist,tmp)
			rm(tmp)
		}
	}
}

# Now normalize a few thing
# We drop the verbose description of the article (authors, etc.) to later pick it up again from Crossref


# There are three typos as of 2018-10-15 which we fix here
repllist2 <- repllist %>% mutate(DOI = ifelse(
		DOI == "10.1257/aer.2013047",
		"10.1257/aer.20130479",DOI)) %>%
		mutate(DOI = ifelse(
			DOI == "10.1257/app.4.1.247",
			   "10.1257/app.4.2.247",
			   DOI))

saveRDS(repllist2,file=file.path(interwrk,"replication_list_2.Rds"))


