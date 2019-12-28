# Module UI

#' @title   mod_result_table_ui and mod_result_table_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_result_table
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_result_table_ui <- function(id){
  ns <- NS(id)
  tagList(
    DT::dataTableOutput(ns("data_disp"))
  )
}

# Module Server

#' @rdname mod_result_table
#' @export
#' @keywords internal
#' @importFrom data.table %inrange%

mod_result_table_server <- function(input,
                                    output,
                                    session,
                                    ms_object,
                                    ppm,
                                    select_column,
                                    select_attr,
                                    offset){
  
  ns <- session$ns
  
  'Accurate Mass' <- precursorMZ <- NULL # For data.table eval
  
  output$data_disp <- DT::renderDataTable( 
    class = 'nowrap display',
    {
      
      shiny::validate(
        shiny::need(
          mzfinder::check_mzr_header(ms_object$header),
          "Unexpected MS header, try uploading mzMLor mzXML again.")
      )
      shiny::validate(
        shiny::need(
          !is.null(ppm()),
          "ppm_input must not be null")
      )
      shiny::validate(
        shiny::need(
          ppm() > 0L,
          "ppm_input must be > 0")
      )
      x <- plotly::event_data("plotly_click", source = "mass_select")$pointNumber + 1
      print(plotly::event_data("plotly_click", source = "mass_select"))
      # x <- plotly::event_data("plotly_selected", source = "mass_select")$pointNumber+1
      
      shiny::req(!is.null(x))
      shiny::req(x > 0L)
      
      if (select_column() == "No Filter" || is.null(select_attr())) {
        
        as.data.frame(
          npatlas[`Accurate Mass` %inrange% ms_object$header[x , list(minus = precursorMZ - offset() - scale_ppm(precursorMZ, ppm()),
                                                                      plus = precursorMZ - offset() + scale_ppm(precursorMZ, ppm()))]]
        )
      } else {
        
        as.data.frame(
          
          npatlas[`Accurate Mass` %inrange% ms_object$header[x , list(minus = precursorMZ - offset() - scale_ppm(precursorMZ, ppm()),
                                                                      plus = precursorMZ - offset() + scale_ppm(precursorMZ, ppm()))] & get(select_column()) == select_attr()]
          
          
        )
      } 
      
    })
}

## To be copied in the UI
# mod_result_table_ui("result_table_ui_1")

## To be copied in the server
# callModule(mod_result_table_server, "result_table_ui_1")

