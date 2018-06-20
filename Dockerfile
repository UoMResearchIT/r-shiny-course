FROM rocker/rstudio:3.5.0
COPY Rprofile.site /usr/local/lib/R/etc/
# COPY rserver.conf /etc/rstudio/ # insecure for debug

# Do the package compilation in parallel
ENV MAKEFLAGS="-j 7"

# Additional packages needed for tidyverse/knitr
RUN apt-get update && \
 apt-get install -y --no-install-recommends \
 libcurl4-openssl-dev libssl-dev libxml2-dev \
 zlib1g-dev libssh2-1-dev texlive-latex-extra \
 vim && apt-get clean
RUN Rscript -e 'install.packages(c("ggplot2","dplyr","readr", "tibble","magrittr", "shiny", "shinythemes", "RCurl", "RJSONIO", "PKI", "rstudioapi", "yaml", "packrat", "rsconnect"))'

