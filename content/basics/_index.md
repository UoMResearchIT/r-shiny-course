---
title: "Getting started"
chapter: true
weight: 5
pre: "<b>1. </b>"
---

### Chapter 1

# Getting started with Shiny

## Creating a Shiny app

The most straightforward way of creating a new Shiny app is to use R Studio.  From the menu, choose, File, New, Shiny Web App.  

Choose a suitable name for your app (e.g. "gapminder").   Leave the other options as their defaults ("Single File", and Create within directory: `~/mawdsley`).  [git:01_defaultapp](https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials/commit/65f7be7dc0b2c9d908b558130107db8d1f483178)

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
The working directory of your R session is probably the project's directory (i.e. `~/mawdsley` - this is displayed at the top of the console window).  When you run the app, it runs in its own working directory (e.g. `~/myworkshop/gapminder`).   If you're interactively running bits of your code you may find it helpful to set the working directory to your app's directory. You can do this by typing `setwd("~/myworkshop/gapminder")`
{{% /notice %}}

### Exercise

* Copy the `gapminder.rds` and `workshopFunctions.R` files into your app directory.
* load the `ggplot2` and `dplyr` libraries at the start of the app
* Modify the app to load the `gapminder.rds` into an object called `gapminder` using the `readRDS()` function
* `source()` the `workshopFunctions.R` file to make the functions
* Check your app still works - the output will be unchanged at this stage, but if there are any errors loading the functions or data you will see these in RStudio's console window.

{{% notice tip %}}
You may wish to look at the `codeExample.R` file, which contains examples of loading libraries and functions
{{% /notice %}}

### Solution

[git:02_loaddata](https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials/commit/7f3298332b887b2015d8b6636e46b4a37bb15906)
