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

Choose a suitable name for your app (e.g. "gapminder").   Leave the other options as their defaults ("Single File", and Create within directory: `~/mawdsley`).

> ## Single vs multiple files
>
>When we create a new Shiny app we can create a single file (`app.R`), or as two separate files (`ui.R` and `server.R`).   The latter format used to be the only method of definining an Shiny app, but can still be useful when building a more complicated app, as it allows us to separate the user interface (`ui.R`) from the server logic (`server.R`).  As we will be building a relatively small app, we'll use the single file approach.  

When we create a new Shiny app in R Studio, it creates an example app that allows us to alter the number of bins in a histogram.  This uses an example data-set that is provided with R of the waiting times for the eruption of the "Old Faithful" geyser.

We can run the app by pressing the "Run App" button in the toolbar (or by pressing Ctrl+Shift+Enter).  This will launch an browser window within R Studio where we can interact with our app.  



> ## Getting help
> 
> There is a cheat sheet for Shiny included with RStudio.  This can be accessed from the menu: Help, Cheatsheets, Web Applications with shiny.

