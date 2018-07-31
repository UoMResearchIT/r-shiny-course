---
title: "App layout"
author: "David Mawdsley"
---



This lesson looks at how we can alter the layout of the page elements.

## Page layout

In the main part of this workshop we used the `fluidPage()` layout, with a `sidebarLayout()`.  This gives us a sidebar (`sidebarPanel()`) and a `mainPanel()`.   This is often (roughly) what we need; a small panel to set the controls for the app, and a large panel to display the app's output (though what you put in each panel is up to you).

We can construct more flexible `fluidPage()` layout using the `fluidRow()` and `column()` functions.  These let us define our app on a grid, placing page elements within each cell.  The structure of UI using this approach is:


```r
ui <- fluidPage(
  fluidRow(
    column(4,

    ),
    column(8,

    )
  ),
  fluidRow(
    column(4,
           <<page elements>>),
    column(4,
           <<page elements>>),
    column(4,
           <<page elements>>)
  )
)
```

The digits give the (relative) width of each column; these should sum to 12 for each row.

### Exercise

Modify your app to display the graph across the whole width of the screen, with any of the outputs you may have created in the [reactive data]({{<ref "reactive" >}}) or [interacting with graphs]({{<ref "../graphs" >}}) lessons below.


Place the continent and year widgets side-by-side below the graph.

### Solution

[git:14_layout](https://github.com/UoMResearchIT/RSE18-shiny-workshop-materials/commit/faa51d9e12027fba50bf57021dfbbfa1761cb8d8)

