---
title: "User Interface design"
chapter: true
weight: 10
pre: "<b>2. </b>"
---
### Chapter 2

# User interface design.

We can see in the example app that it is split into two sections; the user interface (`ui`), and a server function.   We'll deal with each of these in turn..

## The UI section

The user interface of the default app uses the `fluidPage()` to create the app's layout. The fluidPage layout will automatically respond to changes in browser size.  Within the `fluidPage()`, we use a `sidebarLayout()` to split the page into two sections; the `sidebarPanel()` which contain (in the example) the app's input (the slider) and the `mainPanel()` which in the example app contains the histogram output.   This is a fairly typical layout for a Shiny app (note that there's nothing stopping us putting more output above the `sidebarLayout()` - for example the `titlePanel()`, or after it - we could, for example use a `p()` tag to include further text, or add further widgets, outputs etc.).   Each element of the page is an argument to a function, with `fluidPage()` at the top level.  It's easy to forget this when building an interface, and to forget to place the commas between arguments.  

More flexible, but complex layout options are available, such as `navBarPage()`, to produce a page with a navigation bar.  It's also possible to build a [user interface from scratch](https://shiny.rstudio.com/articles/html-ui.html), using HTML, CSS etc.

For this tutorial we'll stick with the `fluidPage()` approach.  Most common html tags have a builder function associated with them.  So to add a paragraph of text to the app, we can pass another argument to the `fluidPage()` function:


```r
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   p("Here is some text"),
   # Sidebar with a slider input for number of bins 
   sidebarLayout(....
```

A very important type of element we can add to the app is a widget.  This provides a control that lets us interact with our app.  The default app has a single widget - the slider that  lets us select the number of bins we want the histogram to have:


```r
sliderInput("bins",
            "Number of bins:",
            min = 1,
            max = 50,
            value = 30)
```

The first argument of the function defines the inputId - essentially this is the name of the variable that the widget's output (in this case the selected number of bins) is assigned to.  The second argument defines the label for widget.  The other arguments are widget specific; in this case they define the scale of the widget and its default value.   

Shiny comes with a number of built in widgets that give different ways of interacting with our app. [The Shiny Widget Gallery](https://shiny.rstudio.com/gallery/widget-gallery.html) lists built in widgets, along with example code to use them.

### Exercise:

* We want to be able to show the data for selected continents only.   The `checkboxGroupInput()` widget will let us do this.   Add one to the app, with `inputId="continent"`.  

{{% notice tip %}}
You will need to provide a vector containing the continent names as the `choices` argument; this can be done using `levels(gapminder$continent)`.  By default none of the check-boxes are selected; this can be changed using the `selected` argument.
{{% /notice %}}

{{% notice note %}}
For now the check boxes won't do anything; we've not made use of the widget's values anywhere in the app - we'll do this shortly.
{{% /notice %}}

* Change the title of the app in the `titlePanel()` to something sensible

###  Solution:
 
[git:03_continentwidget](https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials/commit/c384dd124d40709a4d3000cbc16c89aaa67f0845)

## Displaying R outputs

The `mainPanel()` of the user interface contains a single element in the example app.  The `plotOutput()` displays a plot - in the example app called `distPlot`.  We'll come to how that plot is defined in a moment.  For now, note that there are several `...Output()` functions for displaying various types of output from R, such as `renderTable()` and `renderText


There is more information on altering the layout of Shiny apps, and altering the theme of the apps in the extra [app layout]({{<ref "goingfurther/layout" >}}) lesson.

## The server function

The server function contains the code behind the webapp.   Each `...Output()` function in the user interface has a corresponding `render...()` function.   The first argument of the `render...()` function contains the R code to generate the thing we want to render.  For example, in the example app, the `renderPlot()` function contains the code that will generate a histogram.  As this neeeds to b a single expression this will typically be contained in `{}`s 

Let's briefly look at the example code that generates the histogram:


```r
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
```

`input$bins` will contain the value of the slider which was defined in the user interface (which was called `bins`).   This is how we connect elements of the user interface to the the server logic.

The first argument of `renderPlot()` returns a graph; _how_ we make that graph is up to us.  In the example app, base R graphic are used.  We'll be using ggplot2 in this workshop, as it's easier to make nice looking graphs with it.  To simplify things I've put the ggplot functions within a wrapper function, which we loaded earlier ( [git:02_loaddata](https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials/commit/7f3298332b887b2015d8b6636e46b4a37bb15906) ) .  The important thing is that the first (and in the example, only) argument returns a graph object.   We can also pass arguments to manually control the width and height of the plot, etc.

## Reactivity (How Shiny responds to events) 

Shiny uses a reactive programming model.  This means that when something changes (such as the slider being moved), everything that depends on that something will be updated automatically.   In the example app the only thing that depends on the slider is the `distPlot` graph, so this will be redrawn if we move the slider.

The graph also depends on some other properties of the app, which we can't see directly, such as the window size.  If we resize the window, Shiny knows that the graph depends on that property of the app, and so will redraw the graph.

Shiny automatically takes care of the dependencies between the various elements, and only updates what is needed.  This is covered in more detail in the section on [reactivity]({{< ref "reactive" >}}).
