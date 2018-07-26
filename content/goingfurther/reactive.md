---
title: "Reactive data"
weight: 51
---


In this example we only use the filtered gapminder data in a single place - to plot the graph.   For this reason we did the filtering within the `renderPlot()` function.   

Let's add another output to the app; we'll show which country is the richest displayed on the graph, and what its GDP per capita is. This means that we'll be using the gapminder data filtered by year and country in two places; on the graph itself and in the logic where we work out what the richest country is.   

To do this, we'll make the a reactive expression, which contains the data we want to plot.  A rective expression is an expression whose value can change during the running of the app.   As mentioned previously, the reactive programming approach means that Shiny will keep track of when reactive expressions have become invalid (for example, if their inputs have changed - in this example if `year` or `continent` change), and will then recalculate them automatically.  

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

The app will behave in the same way as before, but by definining the reactive expression `plotData()` we can use the data that we're plotting on the graph elsewhere in the app.

## Exercise

The `renderTable()` function will render a tibble, and `tableOutput()` will display it.   Use these functions, with the reactive data to display a (long) table containing the data displayed on the graph.
  
The `getRichestCountry()` function in `plottingFunctions.R` will return a tibble containing the name of the richest country in a tibble, and the country's GDP per capita. Modify your `renderTable()` function to only display this information for the displayed graph.













