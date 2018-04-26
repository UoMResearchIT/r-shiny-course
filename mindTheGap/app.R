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
      checkboxInput("logx", label = "Log x axis"),
      radioButtons("yvar", label = "Y variable",
                   choices = names(gapminder)),
      checkboxInput("logy", label = "Log y axis")
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("gapminderPlot")
    )
  )
)


server <- function(input, output) {
   
   output$gapminderPlot <- renderPlot({
     g <- ggplot(data = gapminder, aes_string(x = input$xvar, y = input$yvar,
                                              group = "country", colour = "continent")) +
       geom_line() + 
       geom_point()
     
     if (input$logx) {
       g <- g + scale_x_log10()
     }
     
     if (input$logy) {
       g <- g + scale_y_log10()
     }
    print(g)
   })
   
}

# Run the application 
shinyApp(ui = ui, server = server)

