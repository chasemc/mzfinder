# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

library(BiocManager)
options(repos = BiocManager::repositories())
library(mzR)
library(data.table)
library(shiny)

pkgload::load_all()
options( "golem.app.prod" = TRUE)
mzfinder::run_app() # add parameters here (if any)
