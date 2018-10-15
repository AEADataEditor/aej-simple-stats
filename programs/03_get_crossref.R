# This program reads the data created by the replicators and attached DOI information


repllist2 <- readRDS(file=file.path(interwrk,"replication_list_2.Rds")) %>% select(DOI)

# We look up the Crossref DOI. This can take a while
tic.clear()
tic("Query to CrossRef")
bibinfo <- cr_cn(repllist2$DOI, format = "bibentry")
toc()
saveRDS(bibinfo,file=file.path(dataloc,"crossref_query.Rds"))
# convert to data frame
bibinfo.df <- sapply(bibinfo,function(x) as.data.frame(x)) %>% bind_rows() %>% distinct()
names(bibinfo.df)[1] <- "DOI"
saveRDS(bibinfo.df,file=file.path(interwrk,"crossref_info.Rds"))
write.csv(bibinfo.df,file=file.path(interwrk,"crossref_info.csv"))
