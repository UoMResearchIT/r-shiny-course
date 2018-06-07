FROM rocker/rstudio:3.5.0
COPY Rprofile.site /usr/local/lib/R/etc/
# COPY rserver.conf /etc/rstudio/ # insecure for debug


