# We clean up additional variables on repllist (which is manually coded)
# 

repllist3 <- readRDS(file=file.path(interwrk,"replication_list_clean.Rds"))

# The variable Replicated is a bit noisy:

table(repllist3$Replicated)

# We recode
val.partial <- c("partial","partially","partly","yes(?) table 3 still unable to replicate","mostly")
val.yes <- c("yes","y")


repllist4 <- repllist3 %>% 
	mutate(replicated_clean = 
		   	ifelse(tolower(Replicated) %in% val.partial,
				  "partially",
				  ifelse(tolower(Replicated) %in% val.yes,
				  "yes",
				  tolower(Replicated))
		   )
	)

saveRDS(repllist4,file=file.path(interwrk,"replication_list_clean.Rds"))
