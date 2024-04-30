#' Run package tests and create badge
#' 
#' This function uses the \code{covr} package to run tests for a package and 
#' returns a markdown badge code reporting the code coverage that can be used on
#' a README (or any markdown).
#' 
#' @param package path to package
#' 
#' @export
test_and_badge <- function(package = "."){
  pkg_cov <- covr::package_coverage(package)
  cov_perc <- round(covr::percent_coverage(pkg_cov), 1)
  color_rmp <- colorRampPalette(c("darkred", "yellow", "darkgreen"))(10)
  color_rmp <- gsub("#", "", color_rmp)
  indx <- ifelse(round(cov_perc/10) == 0, 1, round(cov_perc/10))
  my_color <- color_rmp[indx]
  badge <- badger::badge_custom("test coverage", paste0(cov_perc, "%"), 
                                my_color)
  cat(badge)
}

