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
  
  
observeEvent(input$rbusiness, {
  output$plot <- renderPlot({
    autoplot(BUSINESS, color = '#ff8200')
    
  })})
  
observeEvent(input$rholiday, {
    output$plot <- renderPlot({
      autoplot(HOLIDAY, color = '#82ff33')
      
   })})
    

observeEvent(input$rvisiting, {
  output$plot <- renderPlot({
    autoplot(VISITING, color = '#ff7933')
    
  })})

observeEvent(input$rother, {
  output$plot <- renderPlot({
    autoplot(OTHER, color = '#1fecfa')
    
  })})



  output$plot <- renderPlot({
    autoplot(MYDATA)
  })

}

shinyApp(ui, server)