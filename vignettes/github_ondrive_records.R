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
#  install.packages("pak")
#  pak::pkg_install("usepa/epar")
#  library(epar)

## ----eval=FALSE---------------------------------------------------------------
#  mirror <- one_drive_mirror("projects")
#  add_mirror_repo(mirror)

## ----install_epar, eval=FALSE-------------------------------------------------
#  pak::pkg_install("usepa/epar")
#  library(epar)

## ----mirror-------------------------------------------------------------------
my_mirror <- one_drive_mirror("projects")
my_mirror

## ----add_mirror, eval=FALSE---------------------------------------------------
#  add_mirror_repo(my_mirror)

