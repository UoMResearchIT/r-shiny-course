# Manchester University Research IT Shiny Course 

This repo contains the website,  slides and other material for the The University of Manchester Shiny Course.  It is based on the workshop that was given at the [RSE2018 conference](https://rse.ac.uk/conf2018/).  The material as delivered at the conference is archived at https://github.com/UoMResearchIT/RSE18-shiny-workshop ( [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1409659.svg)](https://doi.org/10.5281/zenodo.1409659) ).

The website for the workshop is at https://uomresearchit.github.io/r-shiny-course

The RSE workshop assumed knowledge of git as a prerequisite.  This was used to make navigating the course's running example easier.  This requirement has been dropped from this version of the course.

## Build/modification process

To build the site from scratch, clone this repo, and submodules (`git clone --recurse-submodules ...`). You will also need to clone the [learn theme](https://github.com/matcornic/hugo-theme-learn) to the `themes` directory:

```
$ cd themes
$ git clone https://github.com/matcornic/hugo-theme-learn.git
```

To edit the webpage or slide show, edit the relavant `.Rmd` file.  **Do not edit the `.md` files - these are automatically generated**.  `make` will build the site and slideshow as required.  The build process for the `.Rmd` files is:

1. Resolve links of the form `[git:tagname]()` to the appropriate page on github.  This step will fail by design if there are any unresolved links (i.e. there isn't a commit with tag "tagname" in the coursematerial repository)

2. The `.Rmd` files will be "knitted" to `.md` files ready for Hugo.  R code snippets within them will be executed and the output included in the `.md` file.

`hugo serve` will let you locally preview the changes.  `make cleancontent` will delete all the generated `.md` files.  It's safer to stop the local server before running this and regenerating the content if needed; otherwise the left hand menu isn't generated reliably.

Push the repo to github to deploy.

### Editing the gapminder data

The gapminder data used in the course is different from that included in the [gapminder R package](https://cran.r-project.org/web/packages/gapminder/index.html).  The data in this course has values for every year rather than the 5 year intervals uses in the gapminder package.  The `createData.R` script pulls together the source data (downloaded from the gapminder website), deals with standardising country names, etc.

The data included also contains total fertility rate and subregion - I ended up not using these in the course, but I've left them in in case we use them when we extend the workshop to a Research IT training course.

