---
title: "Getting started"
chapter: true
weight: 5
pre: "<b>1. </b>"
---

### Chapter 1

# Getting started with Shiny

## Creating a Shiny app

We'll start by making a new project to contain our app.   We suggest making this in `C:\work`.  From RStudio, choose File, New Project, New Directory, Shiny Web Application.

Choose a suitable name for the directory (e.g. "gapminder").   For "Creat project a subdirectory of:" we suggest using `c:\work`.  At the end of the course, you can copy your project directory to your P drive.  [01_defaultapp](https://github.com/UoMResearchIT/r-shiny-course-materials/commit/630e15f29031d4ac180423251fd8324e36ee9a2f)

{{% notice info %}}
When we create a new Shiny app we can create a single file (`app.R`), or as two separate files (`ui.R` and `server.R`).   The latter format used to be the only method of defining an Shiny app, but can still be useful when building a more complicated app, as it allows us to separate the user interface (`ui.R`) from the server logic (`server.R`).  As we will be building a relatively small app, we'll use the single file approach.  
{{% /notice %}}

When we create a new Shiny app in R Studio, it creates an example app that allows us to alter the number of bins in a histogram.  This uses an example data-set that is provided with R of the waiting times for the eruption of the "Old Faithful" geyser.

We can run the app by pressing the "Run App" button in the tool-bar (or by pressing Ctrl+Shift+Enter).  This will launch an browser window within R Studio where we can interact with our app.  

{{% notice tip %}}
There is a cheat sheet for Shiny included with R Studio.  This can be accessed from the menu: Help, Cheatsheets, Web Applications with shiny.
{{% /notice %}}

## Loading our libraries and functions

The default app doesn't use any additional libraries, functions or external data.  Before going any further we'll add these to the example app.

{{% notice tip %}}
The working directory of your R session is probably your `P:/` (this is displayed at the top of the console window).  When you run the app, it runs in its own working directory (e.g. `c:/work/gapminder`).   If you're interactively running bits of your code you may find it helpful to set the working directory to your app's directory. You can do this by typing `setwd("c:/work/gapminder")`
{{% /notice %}}

### Exercise

* Copy the `gapminder.rds` and `workshopFunctions.R` files into your app directory.
* load the `ggplot2` and `dplyr` libraries at the start of the app
* Modify the app to load the `gapminder.rds` into an object called `gapminder` using the `readRDS()` function
* `source()` the `workshopFunctions.R` file in the app to make the functions available to the app
* Check your app still works - the output will be unchanged at this stage, but if there are any errors loading the functions or data you will see these in RStudio's console window.

{{% notice tip %}}
You may wish to look at the `codeExample.R` file, which contains examples of loading libraries and functions
{{% /notice %}}

### Solution

[02_loaddata](https://github.com/UoMResearchIT/r-shiny-course-materials/commit/f634302b6cdcc46c7d543ccb90f0cad49f7a32ab)
