#' ---
#' local libraries


#' Define the list of libraries
<<<<<<< HEAD
libraries <- c("dplyr","devtools","googlesheets","rcrossref","readr","tidyr")
=======
libraries <- c("dplyr","devtools","googlesheets","rcrossref","readr")
>>>>>>> ff4b3ba93c5441bec975e99441a0f8840af58d0c

#install_github("cboettig/knitcitations")
#install.packages("knitcitations")
#require(knitcitations)

results <- sapply(as.list(libraries), pkgTest)
cbind(libraries,results)
