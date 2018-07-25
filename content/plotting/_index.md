---
title: "Producing plots"
chapter: true
weight: 20
pre: "<b>3. </b>"
---
### Chapter 3

# Producing plots


## Plotting a "gapminder" graph

In order to avoid getting bogged down on the syntax of ggplot2, a function to produce a "gapminder" plot is provided in the `plottingFunctions.R` file.  This uses ggplot2 to produce a graph, deals with setting fixed axes, consistent colours etc.

Stepping aside from Shiny, we can produce a gapminder plot in R using the following code:





```r
# Load the required libraries
library(ggplot2)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(shiny)
```

```
## Loading required package: methods
```

```r
# Load the gapminder data 
#gapminder <- readRDS("gapminder.rds")

# Load the plotting functions
#source("plottingFunctions.R")

# Produce a plot for a year of data
# produceGapminderPlot expects a single year of data
gapminder %>% 
  filter(year == 2000) %>% 
  produceGapminderPlot()
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)


## Exercise:

Add another `filter` to the example to only show countries that are in Europe and Africa

## Solution:


```r
gapminder %>% 
  filter(year == 2000) %>% 
  filter(continent %in% c("Europe", "Africa")) %>% 
  produceGapminderPlot()
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png)


