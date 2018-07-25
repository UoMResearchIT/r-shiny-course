---
title: "Putting it all together"
chapter: true
weight: 30
pre: "<b>4. </b>"
---
### Chapter 4

# Putting it all together
## Back to Shiny

The example app doesn't load any external data or functions (The `faithful` dataset is provided with R).  When we run an app, it sets its location as the working directory.  When we deploy an app it is much easier if all its dependencies are in the same directory.  

* Copy the data (`gapminder.rds`) and plotting functions (`plottingFunctions.R`) into your app directory.  

* Modify the example app to load the `ggplot2` and `dplyr` libraries, the gapminder data from `gapminder.rds` and the plotting functions in `plottingFunctions.R`


## Exercises

* Modify the Shiny app to produce a gapminder plot instead of the histogram.   Note that the `produceGapminderPlot()` requires a single year of data, so you will need to `filter()` the data to a single year before passing it to the function.

* Use the widget you created earlier to only show data for the selected continents

* Create a new widget (or modify the `bins` widget) to let the user choose the year of data to plot. You might want to check out the `sep` option to deal with the thousand separator commas.  

* (optional) check out the options for the `sliderInput()` widget and add an animation button.

* If you created a new widget, you can delete the `bins` widget as we are no longer using this.


We've now created a working app, which lets us explore the data by year and filter by continent.  To summarise:

* Define your server function and user interface 
* Create graphs in the server function  using `renderPlot()`, and other types of output using `render....()` functions
* Display graphs using `plotOutput()` (or `...Output()` for other types of output) in your user interface
* Connect widgets to outputs using `input$inputID` 
* Shiny takes care of updating outputs when inputs change (recative programming)

