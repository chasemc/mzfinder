
search_gnps <- function(precursor = NULL,
                        mass = NULL,
                        intensity = NULL){
  
  if (!is.numeric(precursor)) {
    stop() 
  }
  
  if (!is.numeric(mass)) {
    stop() 
  }
  
  if (!is.numeric(intensity)) {
    stop() 
  }
  
  if (length(mass) != length(intensity)) {
    stop() 
  }
  
  spectrum <- gsub(" ", 
                   "",
                   paste(mass,
                         intensity,
                         sep = "\t ",
                         collapse = "\n"))
  
  
  base_url <- 'https://gnps.ucsd.edu/ProteoSAFe/index.jsp#'
  
  workflow_json <- "\"workflow\":\"SEARCH_SINGLE_SPECTRUM\""
  
  precursor_json <-  paste0("\"precursor_mz\":\"",precursor,"\"")
  
  spectrum_json <- paste0("\"spectrum_string\":\"", spectrum)
  
  z <- paste0(base_url,
              "{",
              workflow_json,
              ",",
              precursor_json,
              ",",
              spectrum_json,
              "\"",
              "}")
  
  z <- gsub(" ", "", z)
  z <- gsub("\"" , "%22", z)
  z <- gsub("\\t","%5Ct", z)
  z <- gsub("\\n","%5Cn", z)
  z
}

