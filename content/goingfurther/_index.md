---
title: "Going further"
chapter: true
weight: 50
pre: "<b>6. </b>"
---


### Chapter 6

This section contains further exercises and examples of using Shiny.

The [Reactive data]({{<ref "reactive" >}}) lesson looks at a better way of handling the data we plot on the graph, so we can use it more than once.  Reactivity is an important concept in Shiny.    The [interacting with graphs]({{< ref "graphs" >}}) lesson looks at how we can use reactivity and events to get more information about a country when we click its point on the graph.  You should complete the [reactive data]({{<ref "reactive" >}}) lesson before this lesson.

The [layout]({{<ref "layout" >}}) lesson looks at changing the layout of the user interface.  It doesn't have any dependencies besides the first part of the workshop.

In this course we've limited our outputs to graphs and text.  Although we don't cover it here, you can add other output types, such as [leaflet maps](http://rstudio.github.io/leaflet/), [plotly graphs](https://plot.ly/r/), and [network diagrams](http://christophergandrud.github.io/networkD3/).  These almost invariably follow the same approach; `render...()` defines the output in the server function, and a `...Output()` function displays it in the user interface.

## Going further

There are a number of online tutorials on Shiny.  [RStudio provide a page which contains links to many of them](https://shiny.rstudio.com/tutorial/).  The tutorial by [Dean Attali](https://deanattali.com/blog/building-shiny-apps-tutorial/) is very good.

## Deploying your own server

We covered publishing your app on [shinyapps.io](https://www.shinyapps.io/) in the [deployment]({{<ref "deploy" >}}) section.  If you want to host your own apps, you can do this using [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server/).   This comes in open source and commercial flavours.

Installation on most common Linux platforms is usually straightforward. If you're comfortable using Docker the [Rocker project's](https://github.com/rocker-org/rocker) [Docker image](https://hub.docker.com/r/rocker/shiny/) is even easier to deploy.  

[Shinyproxy](https://www.shinyproxy.io/) lets you apply authentication, and improve the scalability of your apps using docker-(swarm) or Kubernates, using the open source version of Shiny server.


