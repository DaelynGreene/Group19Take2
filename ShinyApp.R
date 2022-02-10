library(shiny)
library(fpp3)
library(plotly)
data("tourism")
MYDATA <- subset(tourism, tourism$Region == "Adelaide")

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      
    ),
    
    mainPanel(
      plotOutput("plot"),
      
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    autoplot(MYDATA)
  })
  
  
}

shinyApp(ui, server)