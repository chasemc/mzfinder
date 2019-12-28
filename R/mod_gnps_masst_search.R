# Module UI

#' @title   mod_gnps_masst_search_ui and mod_gnps_masst_search_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_gnps_masst_search
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_gnps_masst_search_ui <- function(id){
  ns <- NS(id)
  tagList(
  uiOutput(ns("search_output")),
  plotOutput(ns("plot_ms2"))
  )
}

# Module Server

#' @rdname mod_gnps_masst_search
#' @export
#' @keywords internal

mod_gnps_masst_search_server <- function(input, 
                                         output,
                                         session,
                                         ms_object){
  ns <- session$ns
  
  precursorMZ <- seqNum <- NULL # for data.table eval
  
  plotly_temp <- reactive({
    plotly::event_data("plotly_click", 
                       source = "mass_select")$pointNumber + 1
  })
  
  
  selected_ms2 <- reactive({
    mzR::peaks(ms_object$mzr_connection,
               ms_object$header[plotly_temp(), seqNum])
  })
  
  
  
  output$gnps_search_link <- shiny::renderUI({
    
    
    req(plotly_temp())
    validate(need(!is.null(plotly_temp()),
                  "Click a point"))
    
    precursor <- round(ms_object$header[plotly_temp(), precursorMZ], 4L)
    z <- search_gnps(precursor = precursor,
                     mass = round(selected_ms2()[,1],
                                  4),
                     intensity = round(selected_ms2()[,2],
                                       4)  
                     )
    
    tags$a(href = z,
           target = "_blank", 
           paste0("Search GNPS MASST for precursor: ",
                  precursor))
    
  })
  
  
  output$search_output <- renderUI({
    req(plotly_temp())
    tagList(
      h3("Search GNPS"),
      p("Must ", 
        tags$a(href = "https://gnps.ucsd.edu/ProteoSAFe/user/login.jsp", 
               target = "_blank",
               "login"),
        "to GNPS first."),
      htmlOutput(ns("gnps_search_link"))
    )
    
  })
  
  
  
  output$plot_ms2 <- shiny::renderPlot({
    req(plotly_temp())
    plot_ms2(selected_ms2())
    
    
  })
  
  
  
}

## To be copied in the UI
# mod_gnps_masst_search_ui("gnps_masst_search_ui_1")

## To be copied in the server
# callModule(mod_gnps_masst_search_server, "gnps_masst_search_ui_1")

