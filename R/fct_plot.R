
#' Title
#'
#' @inheritParams search_npatlas
#'
#' @return plotly
#' @export
#'
plotly_mz_rt <- function(npatlas,
                         ms_object,
                         ppm,
                         select_column,
                         select_attr,
                         offset){

  precursorMZ <- retentionTime <- basePeakIntensity <- NULL
  
  
range02 <- function(x){ (x - min(x)) / (max(x) - min(x)) * (10 - 1) + 1 }
pal <- c("gray", "red")
cols <- rep(0L, nrow(ms_object$header))
cols <- color_if_found(cols = cols,
                       select_column = select_column(),
                       select_attr = select_attr(),
                       ppm = ppm(),
                       npatlas = npatlas,
                       ms_data = ms_object$header,
                       offset = offset())

p2 <- plotly::plot_ly(x = ms_object$header[ , retentionTime / 60],
                      y = ms_object$header[ , precursorMZ], 
                      size = log10(range02(ms_object$header[ , basePeakIntensity / max(ms_object$header[ , basePeakIntensity])])),
                      type = 'scatter',
                      mode = "markers",
                      showlegend = F,
                      source = "mass_select",
                      marker = list(color = cols,
                                    colors = pal)
)

p2 <- plotly::layout(p2,
                     xaxis = list(title = "Retention Time"),
                     yaxis = list(title = "Precursor m/z")
)

plotly::event_register(p2,
                       "plotly_click")
p2

}
