#' Create a header from x-levels of MS connection
#'
#' @param mzr_connection mzR connection
#' @param level MS1, MS2 etc. as integer vector
#'
#' @return mzR header as data.table
#' @export
#'
create_header <- function(mzr_connection,
                          level = 2L){
  
  msLevel <- NULL
  
  if (!is.integer(level)) {
    stop("create_header(level = ) must be an integer")
  }
  
  if (attributes(class(mzr_connection))$package != "mzR") {
    stop("create_header(mzr_connection = ) must be an mzR object")
  }
  
  mzml_header(mzr_connection)[msLevel == level, ]
  
}

#' Connect to an MS file with mzR (Alias for mzR::openMSfile)
#'
#' @return mzR connection
#' @export
#'
#' @inheritParams  mzR::openMSfile
connect_to_ms <- function(filename, 
                          backend = NULL, 
                          verbose = FALSE){
  mzR::openMSfile(filename = filename,
                  backend = backend,
                  verbose = verbose)
}


#' Create a mzR:header but make data.table
#'
#' @param ms_connection An instantiated mzR object.
#'
#' @return data.table mzR header
#' @export
#'
mzml_header <- function(ms_connection){
  data.table::as.data.table(mzR::header(ms_connection))
}
