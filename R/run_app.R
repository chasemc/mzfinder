#' Run the Shiny Application
#'
#' @param ... options
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(...) {
  with_golem_options(
    app = shinyApp(ui = app_ui,
                   server = app_server), 
    golem_opts = list(maxUploadSize=30*1024^2)
  )
}
