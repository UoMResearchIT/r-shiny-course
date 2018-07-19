---
title: "Shiny Workshop - RSE conference 2018"
output: github_document
---




# What I want to cover:

Using Shiny to make an interactive data-driven web app

# Formative assessments:

## Adding a widget to an app

We wish to let the user select 0 or more continents from the data.  Choose a suitable widget from the [Shiny widget gallery](https://shiny.rstudio.com/gallery/widget-gallery.html) to do this, and add it to your app.  

## Adding an output to an app

Add a plot for gdp and life expectancy (either using ggplot directly, or using the pre-built functions)

## Controlling where widgets and outputs are placed

## "Wiring" the widget and output together

Modify app to only show data for selected continents

## Deploying a Shiny app to shinyapps.io

Create an account on shinyapps.io and deploy your app

## Understanding and controlling how events are linked to each other.



# Concepts

## What is Shiny + what can we do with it?

Shiny lets us build interactive web apps, using R.   This means we can use (pretty much) all of R's extensive (and extensible) data analysis and visualisation features in our app.  Essentially, we can take almost any analysis we've done in R, and then make it interactive.   We can run our apps locally, within RStudio (this is what we'll do most of today), make them standalone, either by deploying them to a **Shiny Server**, or to a hosting service, such as https://shinyapps.io (we'll do this today), or even including them in a Markdown document.

Rstudio provide a gallery of other Shiny apps: https://shiny.rstudio.com/gallery/

Shiny works well with many widely used R packages, such as [ggplot2](https://ggplot2.tidyverse.org/), and [Leaflet for R](https://rstudio.github.io/leaflet/).  

In this workshop, we're going to use data from the [Gapminder project](https://www.gapminder.org) to visualise how GDP per capita and life expectancy have changed over time.   This takes one of Hans Rosling's 
[![innovative visualisations](http://img.youtube.com/vi/jbkSRLYSojo/0.jpg)](https://youtu.be/jbkSRLYSojo?t=90) and puts it into Shiny. The app we'll produce can be found here: https://mawds.shinyapps.io/worked_example/



> ## Aside
>
> I've tried to minimise the amount of non-Shiny material in this workshop, but we will need to so some manipulation of the data. I've adopted a [tidyverse](https://www.tidyverse.org/) based approach to doing this, using pipes and filters.  If you're more comfortable using base R you're very welcome to use that approach.   If you need a quick refresher on using the tidyverse to manipulate tabular data, [this episode](https://uomresearchit.github.io/r-tidyverse-intro/04-dplyr/) of the [Data Analysis using R course](https://uomresearchit.github.io/r-tidyverse-intro/), which we teach at the University of Manchester may be useful.

## How the workshop materials work

The material we'll use for this workshop are in the `~/mawdsley` directory.  This contains the gapminder data we'll be plotting (`gapminder.rds`), the Shiny app we're going to be making (a deployed version of this is at https://mawds.shinyapps.io/worked_example/) (in `worked_example/`) and some example code showing how to produce (static) graphs of the gapminder data (in `codeExample.R`).  The example code uses the functions in `plottingFunctions.R` to produce the graphs; this is to reduce the time we spend dealing with the inticacies of ggplot2.

The directory is a git repository.  Each commit is tagged, and represents the solution to an exercise.  (Not sure how best to do this part - either the user makes a *new* git repo in another directory and puts their exercise under version control _or_ creates the app within `~/mawdsley` and leaves their app out of version control, and checks out the various steps).  You can look at the diff for a commit within RStudio, or you can view it on github by clicking the link within the solution, e.g. [git:01_helloworld](https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials/commit/ffe945ba4943bef378d744e941bea6f46f9970c0).

Before we start doing things with Shiny, we'll briefly go through the process of creating a static graph in R of the gapminder data.  The code below shows how to do this:


```r
# Load the required libraries
library(ggplot2)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(shiny)
```

```
## Loading required package: methods
```

```r
# Load the gapminder data 
# (this contains more data than that included in the gapminder R package)
gapminder <- readRDS("gapminder.rds")

# Load the plotting functions
source("plottingFunctions.R")

# Produce a plot for a year of data
# produceGapminderPlot expects a single year of data
gapminder %>% 
  filter(year == 2000) %>% 
  produceGapminderPlot()
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1-1.png)

## Exercise:

Add another `filter` to the example to only show countries that are in Europe and Africa

## Solution:


```r
gapminder %>% 
  filter(year == 2000) %>% 
  filter(continent %in% c("Europe", "Africa")) %>% 
  produceGapminderPlot()
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)



## Creating a Shiny app

The most straightforward way of creating a new Shiny app is to use RStudio.  From the menu, choose, File, New, Shiny Web App.  

Choose a suitable name for your app (e.g. "gapminder").   Leave the other options as their defaults ("Single File", and Create within directory: `~/mawdsley`).

> ## Single vs multiple files
>
>When we create a new Shiny app we can create a single file (`app.R`), or as two separate files (`ui.R` and `server.R`).   The latter format used to be the only method of definining an Shiny app, but can still be useful when building a more complicated app, as it allows us to separate the user interface (`ui.R`) from the server logic (`server.R`).  As we will be building a relatively small app, we'll use the single file approach.  

When we create a new Shiny app in RStudio, it creates an example app that allows us to alter the number of bins in a histogram.  This uses an example data-set that is provided with R of the waiting times for the erruption of the "Old Faithful" geyser.

We can run the app by pressing the "Run App" button in the toolbar (or by pressing Ctrl+Shift+Enter).  This will launch an browser window within RStudio where we can interact with our app.  

The example app doesn't load any external data or functions (The `faithful` dataset is provided with R).  When we run an app, it sets its location as the working directory.  When we deploy an app it is much easier if all its dependencies are in the same directory.  

* Copy the data (`gapminder.rds`) and plotting functions (`plottingFunctions.R`) into the app directory.  

* Modify the example app to load the `ggplot2` and `dplyr` libraries, the gapminder data from `gapminder.rds` and the plotting functions in `plottingFunctions.R`


> ## Getting help
> 
> There is a cheat sheet for Shiny included with RStudio.  This can be accessed from the menu: Help, Cheatsheets, Web Applications with shiny.


## User interface design.

We can see in the example app that it is split into two sections; the user interface (`ui`), and a server function.  

The default app uses `fluidPage()` to create the app's layout, and uses a `sidebarLayout` to split the page into two sections, which contain (in the example) the app's input (the slider) and output (the histogram).  The fluidPage layout will automatically respond to changes in browser size.   

More flexible, but complex layout options are available (give examples)...

Most common html tags have a builder function associated with them.  So to add a paragraph of text to the app, we can pass another arguement to the `fluidPage()` function:


```r
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   p("Here is some text"),
   # Sidebar with a slider input for number of bins 
   sidebarLayout(....
```

A very important type of element we can add to the app is a widget.  This provides a control that lets us interact with our app.  The default app has a single widget - the slider that  lets us select the number of bins we want the histogram to have.  The first argument of the function defines the inputId - essentially this is the name of the variable that the widget's output (in this case the selected number of bins) is assigned to.  The second argument defines the label for widget.   

Shiny comes with a number of built in widgets that give different ways of interacting with our app. [The Shiny Widget Gallery](https://shiny.rstudio.com/gallery/widget-gallery.html) lists built in widgets, along with example code to use them.

## Exercise:

We want to be able to show the data for selected continents only.   The `checkboxGroupInput()` widget will let us do this.   Add one to the app.  You will need to provide a vector containing the continent names as the `choices` argument; this can be done using `levels(gapminder$continent)`.  By default none of the checkboxes are selected; this can be changed using the `selected` argument.





## Reactivity (How Shiny responds to events) - inputs change ==> outputs change




## Outputting things in Shiny


## Deploying Shiny apps

## Starting R/Rstudio (prereq - no material provided)

## Plotting graphs in R/Rstudio (prereq)

## Filtering data in R/Rstudio (Tidyverse) (prereq)







