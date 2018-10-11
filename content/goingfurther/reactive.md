---
title: "Reactive data"
weight: 51
---


In this example we only use the filtered gapminder data in a single place - to plot the graph.   For this reason we did the filtering within the `renderPlot()` function.   

Let's add another output to the app; we'll show which country is the richest displayed on the graph, and what its GDP per capita is. This means that we'll be using the gapminder data filtered by year and country in two places; on the graph itself and in the logic where we work out what the richest country is.   

To do this, we'll make the a reactive expression, which contains the data we want to plot.  A reactive expression is an expression whose value can change during the running of the app.   As mentioned previously, the reactive programming approach means that Shiny will keep track of when reactive expressions have become invalid (for example, if their inputs have changed - in this example if `year` or `continent` change), and will then recalculate them automatically.  

Schematically, we have:

{{<mermaid align="left" >}}
graph LR;
   A[input$year] --> B[plotData]
   B --> C[output$gapminderPlot]
   D[input$continent] --> B
{{< /mermaid >}}

Let's make the plotted data a reactive expression. We add the following code to the `server()` function:


```r
   # The data we wish to plot
   plotData <- reactive({
     gapminder %>% 
       filter(year == input$year) %>% 
       filter(continent %in% input$continent)
   })
```

Reactive expressions return a function, so we refer to the data we're plotting as `plotData()`.  We can use this in our `renderPlot()` function:


```r
   output$gapminderPlot <- renderPlot({
      plotData() %>% 
         produceGapminderPlot() })
```

The app will behave in the same way as before, but by defining the reactive expression `plotData()` we can use the data that we're plotting on the graph elsewhere in the app. [git:07_reactivedata](https://github.com/UoMResearchIT/r-shiny-course-materials/commit/4ee4c74ebc63242c13fa772992a0de067f1a1622)

###  Exercise

- The `renderTable()` function will render a tibble, and `tableOutput()` will display it.   Use these functions, with the reactive data to display a (long) table containing the data displayed on the graph.

### Solution

[git:08_showplotdata](https://github.com/UoMResearchIT/r-shiny-course-materials/commit/b373f1f596296184f7bc2f98b28bf87e3de52522)


{{% notice tip %}}
There are two ways of displaying tabular data in Shiny.  `renderTable()` and `tableOutput()` will show a non-interactive tibble.  You can also use `renderDataTable()` and `dataTableOutput()` to give an interactive table that can be sorted, filtered etc.
{{% /notice %}}


- The `getRichestCountry()` function in `plottingFunctions.R` will return a tibble containing the name of the richest country in a tibble, and the country's GDP per capita. Modify your `renderTable()` function to only display this information for the displayed graph.

### Solution

[git:09_richcountry](https://github.com/UoMResearchIT/r-shiny-course-materials/commit/c48240c18327612d9228e7f8255f53cb131b6d1a)


## Debugging with reactive objects

If something goes wrong, Shiny apps can be more complicated to debug than regular R code.  Because code runs in response to events, rather than our script running linearly, it can be complicated to work out the state of your code at a given moment. Printing the values of variables, using, e.g. `print(myvar)`,  is one of the most straightforward ways of trying to work out what's going on, but this is a bit more complex when we're working with reactive objects and data.

You can only "see" reactive objects, such as `input$year` or `plotData()` from within a reactive context.  This means that we have to access reactive object within a reactive expression, such as `renderPlot()`, or using an observer (which we'll cover in a moment).  This means that we can't inspect the value of, e.g. `input$year` by putting a `print(input$year)` as free code within our server function.

There are two ways around this:

* Put your debug `print()` statement within a reactive expression.  For example, we could print the value of `input$year` whenever the graph is updated using:


```r
output$gapminderPlot <- renderPlot({
   print(input$year)
   
   plotData() %>% 
      produceGapminderPlot()
})
```

* Use the `observe()` function to observe the value of a reactive expression.  The expression in the observe function will be updated whenever its dependencies change.  If we add the expression:


```r
observe(print(input$year))
```

to our server function, the `print()` function will be executed whenever the value of `input$year` changes.  

There is a subtle difference between these two approaches.  The `observe()` function will run whenever its value changes.  The code in the `renderPlot()` function is only executed when the plot is updated.

### Other approaches to debugging

[Rstudio provide a helpful guide to other approaches to debugging Shiny apps](https://shiny.rstudio.com/articles/debugging.html).  If parts of your app aren't updating when you think they should be (or are updating when you don't think they should be), I've found the reactive log approach they describe very helpful.  This shows you a graph illustrating the relationship between the various events occurring in the app.  











