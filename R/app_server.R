#' @import shiny
app_server <- function(input, output, session) {
  
  options(shiny.maxRequestSize = 300 * 1024^2)
  
  ms_object <- reactiveValues(mzr_connection = NULL,
                              header = NULL)
  
  callModule(mod_fileInput_server, 
             "fileInput_ui_1",
             ms_object = ms_object)
  
  observeEvent(ignoreInit = TRUE,
               ms_object$mzr_connection,
               {              
                 shiny::validate(
                   shiny::need(
                     mzfinder::check_mzr_object(ms_object$mzr_connection),
                     "Wasn't able to connect to MS file")
                 )
                 shiny::validate(
                   shiny::need(
                     !is.null(input$ppm_input),
                     "ppm_input must not be null")
                 )
                 shiny::validate(
                   shiny::need(
                     input$ppm_input > 0L,
                     "ppm_input must be > 0")
                 )
                 
                 ms_object$header <- create_header(mzr_connection = ms_object$mzr_connection,
                                                   level = 2L)
               })
  
  
  callModule(mod_mass_rt_plot_server,
             "mass_rt_plot_ui_1",
             ms_object = ms_object,
             ppm = reactive(input$ppm_input),
             select_column = reactive(input$select_column),
             select_attr = reactive(input$select_attr),
             offset = reactive(input$offset))
  
  
  callModule(mod_result_table_server, 
             "result_table_ui_1",
             ms_object = ms_object,
             ppm = reactive(input$ppm_input),
             select_column = reactive(input$select_column),
             select_attr = reactive(input$select_attr),
             offset = reactive(input$offset))
  
  
  output$filter_cols <- shiny::renderUI({
    
    shiny::selectInput("select_column",
                       "Select Column to Filter By",
                       choices = c("No Filter", colnames(npatlas)),
                       selected = "Genus")
    
  })
  
  output$filter_cols2 <- shiny::renderUI({
    req(input$select_column)
    selected_col <- input$select_column
    
    shiny::selectInput("select_attr",
                       paste0("Select ", selected_col),
                       choices = sort(unique(npatlas[, selected_col, with = FALSE][[1]])),
                       multiple = TRUE,
                       selectize = TRUE)
  })
  
  
  callModule(mod_gnps_masst_search_server,
             "gnps_masst_search_ui_1",
             ms_object = ms_object)
  
  
}
