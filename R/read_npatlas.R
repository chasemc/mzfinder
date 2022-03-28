#' Read www.npatlas.org data included within this package
#' @param path path to database tsv
#' @return data.table
#' @export
#' 
#' @importFrom data.table fread
read_npatlas <- function(){
  fread("https://www.npatlas.org/static/downloads/NPAtlas_download.tsv", sep="\t")
}
