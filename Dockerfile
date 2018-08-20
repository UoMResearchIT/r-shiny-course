FROM openanalytics/r-base

MAINTAINER David Mawdsley "david.mawdsley@manchester.ac.uk"

# Do the package compilation in parallel
ENV MAKEFLAGS="-j 7"
COPY Rprofile.site /us/lib/R/etc

# Additional packages needed for tidyverse/knitr
RUN apt-get update && \
 apt-get install -y --no-install-recommends \
 libcurl4-openssl-dev \
 libssl-dev \
 vim && apt-get clean
RUN Rscript -e 'install.packages(c("ggplot2","dplyr","readr", "tibble","magrittr", "shiny", "shinythemes", "RCurl", "RJSONIO", "PKI", "rstudioapi", "yaml", "packrat", "rsconnect"))'

RUN mkdir /root/worked_example
COPY coursematerial/worked_example /root/worked_example

EXPOSE 3838
CMD ["R", "-e", "shiny::runApp('/root/worked_example', port=3838, host = '0.0.0.0')"]

