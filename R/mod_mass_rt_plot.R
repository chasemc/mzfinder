# Module UI

#' @title   mod_mass_rt_plot_ui and mod_mass_rt_plot_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_mass_rt_plot
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_mass_rt_plot_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotly::plotlyOutput(ns("tic_plot"))
  )
}

# Module Server

#' @rdname mod_mass_rt_plot
#' @export
#' @keywords internal

mod_mass_rt_plot_server <- function(input,
                                    output,
                                    session,
                                    ms_object,
                                    ppm,
                                    select_column,
                                    select_attr,
                                    offset){
  
  output$tic_plot <- plotly::renderPlotly({
    shiny::req(nrow(ms_object$header) > 2)
    
    plotly_mz_rt(npatlas = npatlas,
                 ms_object = ms_object,
                 ppm = ppm,
                 select_column = select_column,
                 select_attr = select_attr,
                 offset = offset)
  })
  
}

## To be copied in the UI
# mod_mass_rt_plot_ui("mass_rt_plot_ui_1")

## To be copied in the server
# callModule(mod_mass_rt_plot_server, "mass_rt_plot_ui_1")

