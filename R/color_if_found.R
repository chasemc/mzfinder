
#' Find m/z that match db
#'
#' @param cols m/z index
#' @param ms_data mzr connection and header
#' @param npatlas npatlas as data.table
#' @param ppm dalton difference, not ppm
#' @param select_column optional column filter
#' @param select_attr optional filter value(s)
#' @param offset adduct mass 
#'
#' @return index
#' @export
color_if_found <- function(ms_data,
                           npatlas,
                           cols,
                           ppm,
                           select_column = "No Filter",
                           select_attr = NULL,
                           offset = 1.00784){
  
  
  `Accurate Mass` <- precursorMZ <- NULL
  
  if (select_column == "No Filter" | is.null(select_attr)) {

    z <- apply(abs(outer(npatlas$`Accurate Mass`,
                         ms_data$precursorMZ - offset,
                         "-")),
               2,
               min)
    
    cols[which(z < ppm)] <- 1L
    
  } else {
    z <- apply(abs(outer(npatlas[get(select_column) == select_attr, `Accurate Mass`],
                         ms_data$precursorMZ - offset,
                         "-")),
               2,
               min)
    
    cols[which(z < ppm)] <- 1L
  } 
  return(cols)
}
