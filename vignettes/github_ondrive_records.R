## ----setup, include=FALSE, echo=FALSE-----------------------------------------
################################################################################
#Load packages
################################################################################
library("epar")
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
knitr::opts_chunk$set(purl = NOT_CRAN, 
                      eval = NOT_CRAN,
                      fig.width = 4, 
                      fig.height = 4, 
                      tidy = TRUE,
                      dpi = 100)

## ----environ, echo=FALSE------------------------------------------------------
#key <- readRDS("../tests/testthat/key_file.rds")
#Sys.setenv(mapzen_key=key)

## ----eval=FALSE---------------------------------------------------------------
#  remotes::install_github("usepa/epar")
#  library(epar)

## ----eval=FALSE---------------------------------------------------------------
#  mirror <- one_drive_mirror("projects")
#  add_mirror_repo(mirror)

