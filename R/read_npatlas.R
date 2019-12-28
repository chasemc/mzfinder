#' Read www.npatlas.org data included within this package
#' @param path path to database tsv
#' @return data.table
#' @export
#'
read_npatlas <- function(path){
  path <- list.files(path, 
                     full.names = TRUE,
                     pattern = "np_atlas")
  data.table::fread(path)
  
}
