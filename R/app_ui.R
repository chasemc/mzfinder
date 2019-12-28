#' @import shiny
app_ui <- function() {
  tagList(
    golem_add_external_resources(),
    fluidPage(
      shiny::titlePanel(title =     h1("Search LC-MS/MS Precursors against NPAtlas", align = "center"),
                        windowTitle = "mzFinder"),
      sidebarLayout(
        sidebarPanel(
          p("This app compares MS2 precursors against the NP Atlas database. 
            The input file should be a centroided mzML or mzXML file."),
          mod_fileInput_ui("fileInput_ui_1"),
          numericInput("offset",
                       label = "Adduct mass",
                       value = 1.00784,
                       min = 0,
                       max = 1000,
                       step = .1),
          numericInput("ppm_input",
                       label = "Tolerance (Daltons)",
                       value = .2,
                       min = 0.001,
                       max = 1000,
                       step = .1),
          uiOutput("filter_cols"),
          uiOutput("filter_cols2"),
          mod_gnps_masst_search_ui("gnps_masst_search_ui_1")
        ),
        mainPanel(
          mod_mass_rt_plot_ui("mass_rt_plot_ui_1"),
          mod_result_table_ui("result_table_ui_1")
        )
      )
      
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  addResourcePath('www', system.file('app/www', package = 'mzfinder'))
  tags$head(
    golem::activate_js(),
    golem::favicon(),
    shinybusy::add_busy_spinner(spin = "orbit",
                                position = "bottom-right",
                                margins = c(10,20),
                                timeout = 100)
  )
}
