
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
#library(datasets)
library(MASS)
library(rCharts)

mydata <- Cars93

shinyServer(function(input, output, session) {
  
  output$oManufacturer <- renderPrint({input$Manufacturer2})
  
  output$mytable = renderDataTable({
    MANUFACTURER = input$Manufacturer2
    TYPE = input$Type2
    mydata<- mydata[mydata$Manufacturer %in% MANUFACTURER  & mydata$Type %in% TYPE,]
    mydata<-mydata[,c("Manufacturer","Type","Model","Weight", "Price")]
    mydata
  })
  
  output$myplot<- renderChart2({
    MANUFACTURER = input$Manufacturer2
    TYPE = input$Type2
    mydata<- mydata[mydata$Manufacturer %in% MANUFACTURER  & mydata$Type %in% TYPE,]
    p1<-rPlot(Weight ~ Model, color = 'Model', data = mydata, type = 'bar')
    
    p1$guides(
      color = list(
        numticks = length(factor(mydata$Model))
      ),
      y = list(
        min = 0,
        max = 10
      )
    )
    return(p1)
  })  
  
  output$myprice <- renderPlot({
    plot(Cars93$Manufacturer,Cars93$Price,col=2,cex=2,pch=3)
  })

  
  output$myfactors <- renderPlot({
    Cars93_MPG <- Cars93[,c("Price", "MPG.highway", "EngineSize", "Weight", "Length")]
    plot(Cars93_MPG, main="Scatter Plot Matrix")
  })
  
    
#   output$myprice<- renderChart2({
#     Trial <- summaryBy(.~Price,data=Cars93,FUN=length)
#     Histogram1 <- nPlot(x='Age',y='X.length',group='Sex',data=Trial,type='bar',dom='Histogram1')
#     Histogram1$chart(margin = list(left = 100))
#     return(Histogram1)
#     
# 
#   })    
  
})

# mpgData <- mtcars
# mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))
# 
# shinyServer(function(input, output) {
# 
#   output$distPlot <- renderPlot({
# 
#     # generate bins based on input$bins from ui.R
#     x    <- faithful[, 2]
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
# 
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
# 
#   })
# 
# })
