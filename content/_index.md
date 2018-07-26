---
title: "Introduction to Shiny"
---

# Introduction to Shiny

Shiny lets us build interactive web apps, using R.   This means we can use (pretty much) all of R's extensive (and extensible) data analysis and visualisation features in our app.  Essentially, we can take almost any analysis we've done in R, and then make it interactive.   We can run our apps locally, within R Studio (this is what we'll do most of today), make them standalone, either by deploying them to a [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server/), or to a hosting service, such as https://shinyapps.io (we'll do this today), or even including them in a Markdown document.

R studio provide a gallery of other Shiny apps: https://shiny.rstudio.com/gallery/

Shiny works well with many widely used R packages, such as [ggplot2](https://ggplot2.tidyverse.org/), and [Leaflet for R](https://rstudio.github.io/leaflet/).  

In this workshop, we're going to use data from the [Gapminder project](https://www.gapminder.org) to visualise how GDP per capita and life expectancy have changed over time.   This takes one of Hans Rosling's 
innovative visualisations and puts it into Shiny. 
{{< youtube id="jbkSRLYSojo" start="90" >}}

We'll replicate this in Shiny (albeit without the smooth animation between years):

<iframe src="https://mawds.shinyapps.io/worked_example/" style="border:none; width:100%;  height:700px"></iframe>

{{% notice info %}}
I've tried to minimise the amount of non-Shiny material in this workshop, but we will need to do some manipulation of the data. I've adopted a [tidyverse](https://www.tidyverse.org/) based approach to doing this, using pipes and filters.  If you're more comfortable using base R you're very welcome to use that approach.   If you need a quick refresher on using the tidyverse to manipulate tabular data, [this episode](https://uomresearchit.github.io/r-tidyverse-intro/04-dplyr/) of the [Data Analysis using R course](https://uomresearchit.github.io/r-tidyverse-intro/), which we teach at the University of Manchester may be useful.
 
To minimise the amount of formatting of graphs etc, I've provided functions that will generate the graphs we'll be using, given an appropriate data set.  Where these functions are used you could use your own call to `ggplot()`, `plot()` etc.
{{% /notice %}}


## How the workshop materials work

The material we'll use for this workshop are in the `~/mawdsley` directory.  This contains the gapminder data we'll be plotting (`gapminder.rds`), the Shiny app we're going to be making (a deployed version of this is at https://mawds.shinyapps.io/worked_example/) (in `worked_example/`) and some example code showing how to produce (static) graphs of the gapminder data (in `codeExample.R`).  The example code uses the functions in `plottingFunctions.R` to produce the graphs; this is to reduce the time we spend dealing with the intricacies of ggplot2.

The directory is a git repository.  Each commit is tagged, and represents the solution to an exercise.  (Not sure how best to do this part - either the user makes a *new* git repo in another directory and puts their exercise under version control _or_ creates the app within `~/mawdsley` and leaves their app out of version control, and checks out the various steps).  You can look at the diff for a commit within R Studio, or you can view it on github by clicking the link within the solution, e.g. [git:01_helloworld](https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials/commit/ffe945ba4943bef378d744e941bea6f46f9970c0).



