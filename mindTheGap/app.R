#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(gapminder)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Gapminder visualisation"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      radioButtons("xvar", label = "X variable",
                   choices = names(gapminder)),
      radioButtons("yvar", label = "Y variable",
                   choices = names(gapminder))),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("gapminderPlot")
    )
  )
)
  

server <- function(input, output) {
   
   output$gapminderPlot <- renderPlot({
     g <- ggplot(data = gapminder, aes_string(x= input$xvar, y = input$yvar,
                                              group = "country", colour = "continent")) +
       geom_line() + 
       geom_point()
     
    print(g)
   })
   
}

# Run the application 
shinyApp(ui = ui, server = server)

