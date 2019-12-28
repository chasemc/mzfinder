FROM rocker/tidyverse:3.6.2
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN R -e 'remotes::install_cran("shiny")'
RUN R -e 'remotes::install_cran("golem")'
RUN R -e 'remotes::install_cran("data.table")'
RUN R -e 'remotes::install_cran("mzR")'
RUN R -e 'remotes::install_cran("shinybusy")'
RUN R -e 'remotes::install_cran("DT")'
RUN R -e 'remotes::install_cran("pkgload")'
COPY mzfinder_*.tar.gz /app.tar.gz
RUN R -e 'remotes::install_local("/app.tar.gz")'
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');mzfinder::run_app()"
