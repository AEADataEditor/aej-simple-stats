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

repllist2 <- repllist %>% 
	select(DOI,`Entry Questionnaire`,`Entry Questionnaire Author`,
			 `Expected Difficulty`,Replicator,Completed,Replicated,
			 `2nd Replicator`,Completed_1,Replicated_1,
			 `Data Type`,`Data Access Type`,`Data URL`,`Data Contact`,
			 `Start-time`,`End-time`,`Main Issue`,
			 `Data Access Type: restricted`,`Data Access Type: public`,`Data Access Type: Unknown`) 
	
# There are three typos as of 2018-10-15 which we fix here
repllist2 %>% mutate(DOI = ifelse(
		DOI == "10.1257/aer.2013047",
		"10.1257/aer.20130479",DOI)) %>%
		mutate(DOI = ifelse(
			DOI == "10.1257/app.4.1.247",
			   "10.1257/app.4.2.247",
			   DOI))


# We look up the Crossref DOI. This can take a while
tic.clear()
tic("Query to CrossRef")
bibinfo <- cr_cn(repllist2$DOI, format = "bibentry")
toc()
saveRDS(bibinfo,file=file.path(dataloc,"crossref_query.Rds"))
# convert to data frame
bibinfo.df <- sapply(bibinfo,function(x) as.data.frame(x)) %>% bind_rows() %>% distinct()
names(bibinfo.df)[1] <- "DOI"

# merge back onto repllist2

repllist3 <- left_join(repllist2,bibinfo.df,by="DOI")
saveRDS(repllist3,file=file.path(interwrk,"replication_list_3.Rds"))

