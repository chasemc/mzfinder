# Module UI

#' @title   mod_fileInput_ui and mod_fileInput_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_fileInput
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_fileInput_ui <- function(id){
  ns <- NS(id)
  tagList(
    fileInput(ns("upload_mzml"), 
              "Select mzML or mzXML",
              multiple = FALSE,
              accept = NULL,
              width = NULL, buttonLabel = "Browse...",
              placeholder = "No file selected")
  )
}

# Module Server

#' @rdname mod_fileInput
#' @export
#' @keywords internal

mod_fileInput_server <- function(input, 
                                 output,
                                 session,
                                 ms_object){
  ns <- session$ns

  observeEvent(ignoreInit = TRUE,
               input$upload_mzml,
               {
                 ms_path <- normalizePath(input$upload_mzml$datapath,
                                          winslash = "/")
                 shiny::validate(
                   shiny::need(
                     file.exists(ms_path),
                     "File doesn't exist")
                 )
                 
                 ms_object$mzr_connection <- connect_to_ms(ms_path)
               })
  return(ms_object)
  
}

## To be copied in the UI
# mod_fileInput_ui("fileInput_ui_1")

## To be copied in the server
# callModule(mod_fileInput_server, "fileInput_ui_1")

