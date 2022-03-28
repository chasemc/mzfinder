## code to prepare `npatlas` dataset goes here

npatlas <- read.delim("https://www.npatlas.org/static/downloads/NPAtlas_download.tsv", sep="\t")
usethis::use_data(npatlas,
                 internal = T,
                 overwrite = T)
