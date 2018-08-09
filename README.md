# RSE 2018 Shiny Workshop

This repo contains the website,  slides and other material for the RSE 2018 Shiny Workshop.

The website for the workshop is at https://uomresearchit.github.io/RSE18-shiny-workshop/

The code required for the running example is in a separate repository at: https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials . This is cloned to each user's (virtual) machine.

Each step of the exercises is a separate tagged commit in this repository.  These commits are linked to the relevant github commit page on the workshop slideshow and on the website.

## Build/modification process

To edit the webpage or slide show, edit the relavant `.Rmd` file.  **Do not edit the `.md` files - these are automatically generated**.  `make` will build the site and slideshow as required.  The build process for the `.Rmd` files is:

1. Resolve links of the form `[git:tagname]()` to the appropriate page on github.  This step will fail by design if there are any unresolved links (i.e. there isn't a commit with tag "tagname" in the coursematerial repository)

2. The `.Rmd` files will be "knitted" to `.md` files ready for Hugo.  R code snippets within them will be executed and the output included in the `.md` file.

`hugo serve` will let you locally preview the changes (Although this auto updates when files change, you will need to manually run `make` to generate the `.md` file after editing the `.Rmd` file)

Push the repo to github to deploy.

### Editing the gapminder data

The gapminder data used in the course is different from that included in the [gapminder R package](https://cran.r-project.org/web/packages/gapminder/index.html).  The data in this course has values for every year rather than the 5 year intervals uses in the gapminder package.  The `createData.R` script pulls together the source data (downloaded from the gapminder website), deals with standardising country names, etc.

The data included also contains total fertility rate and subregion - I ended up not using these in the course, but I've left them in in case we use them when we extend the workshop to a Research IT training course.

## Old notes on Docker image

Early work was done in a Docker image - this is no longer needed, as it was more space-efficient to install RStudio etc directly in the virtual machine supplied by the organisers.  Build instructions for this, and a test script are in `vminstall`

The Docker image can be built with `make dockerimage`
The Docker image can be started/stoped with `run|stoprstudio`
The slide deck will be compiled and opened with `make present`

If running the Docker image, connect to `localhost:8787`, username/password: rstudio/rstudio

We also map port 3838 so we can view Shiny apps in the external browser.

Note the RunApp button doesn't seem to work properly in Firefox - the app doesn't initialise properly.   Is OK in Chromium.


