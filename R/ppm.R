

#'  Currently a passthrough
#'
#' @param mass mass vector
#' @param ppm ppm vector
#'
#' @return numeric vector
#' @export
#'
scale_ppm <- function(mass,
                      ppm){
  # Decided not to support ppm diff currently, only dalton-based difference
   ppm
}

