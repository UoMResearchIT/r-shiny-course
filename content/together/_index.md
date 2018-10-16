---
title: "Putting it all together"
chapter: true
weight: 30
pre: "<b>4. </b>"
---
### Chapter 4

## Putting it all together

We've now covered everything we need to make our app.  We'll first replace the histogram with a (non interactive) gapminder plot.  We'll then create a widget to let us select the year. Finally, we'll wire everything together to make the app interactive.

### Exercises

* Modify the Shiny app to produce a static gapminder plot instead of the histogram.   Note that the `produceGapminderPlot()` requires a single year of data, so you will need to `filter()` the data to a single year before passing it to the function.

{{% notice tip %}}
The `outputId` of the plot in the default app is `distPlot` - you should change this to something more descriptive, e.g. `gapminderPlot`.  Remember to change this in both the server function, and in the user interface.
{{% /notice %}}

### Solution 

[04_gapminderplot](https://github.com/UoMResearchIT/r-shiny-course-materials/commit/4e65d595767b89352159626a9866a9138c937ad2)

* Create a new widget, with `inputId="year"` (or modify the `bins` widget) to let the user choose the year of data to plot. You might want to check out the `sep` option to deal with the thousand separator commas, and `step` to alter the "resolution" of the slider.  

* (optional) check out the options for the `sliderInput()` widget and add an animation button.

{{% notice note %}}
The performance of the app isn't great in the virtual machine. You may need to set the `interval` option to reduce the frame rate and prevent the animation lagging.
{{% /notice %}}

* If you created a new widget, you can delete the `bins` widget as we are no longer using this.
 
### Solution
 
[05_yearwidget](https://github.com/UoMResearchIT/r-shiny-course-materials/commit/06e341bf142320efe21b1164ded07e83ac494e5d)
 
* Use the outputs of the year and continent widgets to make the graph interactive

### Solution 

[06_interactive](https://github.com/UoMResearchIT/r-shiny-course-materials/commit/6c8aa4be34deb51218af55541789f48e4790018c)


##  Summary

We've now built our Shiny app.  To recap:

* Define your server function and user interface 
* Create graphs in the server function  using `renderPlot()`, and other types of output using `render....()` functions
* Display graphs using `plotOutput()` (or `...Output()` for other types of output) in your user interface
* Connect widgets to outputs using `input$inputID` 
* Shiny takes care of updating outputs when inputs change (reactive programming)

In the next section we'll look at options for deploying our app.
