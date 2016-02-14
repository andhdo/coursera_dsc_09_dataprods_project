
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(MASS)
require(rCharts)
options(RCHART_LIB = 'polycharts')

mydata<-Cars93

shinyUI(pageWithSidebar(
  headerPanel('Shiny App (Cars93)'),
  sidebarPanel(
    selectInput("Manufacturer2", "Select a Manufacturer", levels(droplevels(mydata$Manufacturer)), selected = "Acura"),    
    selectInput("Type2", "Select a Type", levels(droplevels(mydata$Type))[3:4],selected = levels(droplevels(mydata$Type))[3]),
    verbatimTextOutput("oManufacturer")
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Table",dataTableOutput('mytable')),
      tabPanel("Chart",showOutput('myplot', 'polycharts')),
      tabPanel("Price",plotOutput('myprice')),
      tabPanel("Scatter",plotOutput('myfactors')),
      tabPanel("Plot", plotOutput("distPlot"))
    )
  )
))  


# shinyUI(fluidPage(
# 
#   # Application title
#   titlePanel("Cars93"),
# 
#   # Sidebar with a slider input for number of bins
#   sidebarLayout(
#     sidebarPanel(
#       sliderInput("bins",
#                   "Number of bins:",
#                   min = 1,
#                   max = 50,
#                   value = 30)
#     ),
# 
#     # Show a plot of the generated distribution
#     mainPanel(
#       plotOutput("distPlot")
#     )
#   )
# ))
