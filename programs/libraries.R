#' ---
#' local libraries


#' Define the list of libraries
libraries <- c("plyr","reshape2","data.table","dplyr","magrittr","stargazer","ggplot2","RefManageR","devtools","bibtex","knitcitations","googlesheets","rcrossref")

#install_github("cboettig/knitcitations")
#install.packages("knitcitations")
#require(knitcitations)

results <- sapply(as.list(libraries), pkgTest)
cbind(libraries,results)
