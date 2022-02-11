#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny); library(dplyr); library(ggplot2)

#toy data
dates= seq.Date(as.Date("2020-01-01"),as.Date("2020-05-01"),by="days")
set.seed(1)
data = data.frame(date = dates,val = runif(length(dates),50,150))

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("group","Group",choices = LETTERS[1:3]),
      dateRangeInput('dateRangeCal', "Input date range"),
      selectInput("week","shift week",choices = c(0:3)),
      actionButton("action","Submit")
    ),
    mainPanel(
      plotOutput(outputId = "plot")
    )
  )
)

server <- function(input, output,session) {
  
  week <- reactiveVal()
  
  observeEvent( input$action, {
    week(input$week)
    startDate = as.Date("2020-01-01")+days(case_when(
      input$group == "A" ~ 0,
      input$group == "B" ~ 30,
      input$group == "C" ~ 60
    ))
    endDate=startDate+days(60)
    updateDateRangeInput(session = session, 
                         inputId = 'dateRangeCal',
                         label = 'Date range input:',
                         start = startDate,
                         end = endDate
    )
    
  },ignoreNULL = F)
  
  output$plot <- renderPlot({
    p = data %>%
      filter(date>=input$dateRangeCal[1]+days(week())*7,date<=input$dateRangeCal[2]) %>%
      ggplot(.,aes(x=date,y=val))+
      geom_line()
    p
  })
}

shinyApp(ui, server)

