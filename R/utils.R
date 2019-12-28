#' Check if variable is a mzR obect
#'
#' @param x mzR object
#'
#' @return TRUE/FALSE
#' @export
#'
check_mzr_object <- function(x){
  a <- attr(class(x), "package") == "mzR"
  
  # if (isTRUE(a)) {
  #   b <- x@backend@.xData$getLastScan() > 0L
  # } else {
  #   b = FALSE
  # }
  a + T == 2L
}

#' Check that mzr header is as expected
#'
#' @param x mzr header data.table
#'
#' @return TRUE/FALSE
#' @export
#'
check_mzr_header <- function(x){
  
  a <- all(class(x) == c("data.table", "data.frame"))
  b <- nrow(x) > 1L
  a + b == 2
  
}