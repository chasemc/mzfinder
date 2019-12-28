#' Plot ms2
#'
#' @param selected_ms2 ms2 matrix
#'
#' @return NAA, plot
#' @export
#'
plot_ms2 <- function(selected_ms2){
  
  graphics::plot(x = 0,
                 y = 0,
                 xlim = c(-min(selected_ms2[ , 1]),
                          max(selected_ms2[ , 1])),
                 ylim = c(0, 100),
                 xlab = "m/z",
                 ylab = "Intensity",
                 type = "n")
  graphics::rect(xleft = selected_ms2[ , 1] - 0.5,
                 ybottom = 0,
                 xright = selected_ms2[ , 1] + 0.5,
                 ytop = selected_ms2[ , 2] / max(selected_ms2[ , 2]) * 100
                 )
}