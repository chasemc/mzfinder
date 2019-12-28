
#' Search a mass against np atlas
#' 
#' @param npatlas npatlas data.table
#' @param ms_object mzr connection and header
#' @param ppm dalton difference, not currently ppm difference
#' @param select_column optional column to filter by
#' @param select_attr optional value to filter
#' @param offset adduct mass offset
#' @param selected selected MS event
#'
#' @return data.table
#' @export
#' 
#' @importFrom data.table %inrange%
#'
search_npatlas <- function(npatlas,
                           ms_object,
                           ppm,
                           select_column,
                           select_attr,
                           offset,
                           selected){
  
  precursorMZ <- `Accurate Mass` <- NULL  
  
  if (select_column == "No Filter" || is.null(select_attr)) {
    
    as.data.frame(
      npatlas[`Accurate Mass` %inrange% ms_object$header[selected , list(minus = precursorMZ - offset - scale_ppm(precursorMZ, ppm),
                                                                         plus = precursorMZ - offset + scale_ppm(precursorMZ, ppm))]]
    )
  } else {
    
    as.data.frame(
      
      npatlas[`Accurate Mass` %inrange% ms_object$header[selected , list(minus = precursorMZ - offset - scale_ppm(precursorMZ, ppm),
                                                                         plus = precursorMZ - offset + scale_ppm(precursorMZ, ppm))] & get(select_column) == select_attr]
      
    )
  }
  
}