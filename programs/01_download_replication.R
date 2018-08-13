# This program downloads the data created by the replicators from the
# Google sheets noted in the config.R
# and saves the CSV / R/ DTA files in data/replications_data

exit_gap <- ExitQ.URL %>% gs_url()
results_exit_raw <- exit_gap %>% gs_read_listfeed(ws = "Form Responses 1")
names(results_exit_raw)

entry_gap <- Entry.URL %>% gs_url()
results_entry_raw <- entry_gap %>% gs_read_listfeed(ws = "Form Responses 1")
names(results_entry_raw)
