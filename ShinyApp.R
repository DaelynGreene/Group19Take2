library(shiny)
library(fpp3)
library(plotly)
data("tourism")
MYDATA <- subset(tourism, tourism$Region == "Adelaide")
BUSINESS <- subset(tourism, tourism$Purpose == "Business" & tourism$Region == "Adelaide")
HOLIDAY <- subset(tourism, tourism$Purpose == "Holiday" & tourism$Region == "Adelaide")
VISITING <- subset(tourism, tourism$Purpose == "Visiting" & tourism$Region == "Adelaide")
OTHER <- subset(tourism, tourism$Purpose == "Other" & tourism$Region == "Adelaide")

ui <- fluidPage(
  
  actionButton("rbusiness", "Business"),
  actionButton("rholiday", "Holiday"),
  actionButton("rvisiting", "Visiting"),
  actionButton("rother", "Other"),
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
  #  autoplot(BUSINESS)
  # autoplot(HOLIDAY)
  # autoplot(VISITING)
  # autoplot(OTHER)
  })

  
  
}

shinyApp(ui, server)