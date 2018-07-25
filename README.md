# RSE 2018 Shiny Workshop

This repo contains the website,  slides and other material for the RSE 2018 Shiny Workshop.

The website for the workshop is at https://uomresearchit.github.io/RSE18-shiny-workshop/

The running example is in a submodule.  

Early work was done in a Docker image - this is no longer needed, as it was more space-efficient to install RStudio etc directly in the virtual machine supplied by the organisers.  Build instructions for this, and a test script are in `vminstall`

The Docker image can be built with `make dockerimage`
The Docker image can be started/stoped with `run|stoprstudio`
The slide deck will be compiled and opened with `make present`

If running the Docker image, connect to `localhost:8787`, username/password: rstudio/rstudio

We also map port 3838 so we can view Shiny apps in the external browser.

Note the RunApp button doesn't seem to work properly in Firefox - the app doesn't initialise properly.   Is OK in Chromium.


