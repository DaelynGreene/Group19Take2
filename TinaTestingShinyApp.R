library(shiny)

ui <- fluidPage(
  runExample("11_timer")
)

server <- function(input, output, session) {
  
}


shinyApp(ui, server)






