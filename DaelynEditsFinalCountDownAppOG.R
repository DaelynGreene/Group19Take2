library(lubridate)
library(shiny)
library(audio)
library(shinyWidgets)
palette1 <- rainbow(50)


ui <-
  fluidPage(
    mainPanel(
      align = "center",
      width = 12,
      setBackgroundColor(
        color = c("#ff8200", "#ffffff", "#ff8200", "#ffffff", "#ff8200", "#ffffff", "#ff8200", "#ffffff", "#ff8200", "#ffffff", "#ff8200", "#ffffff", "#ff8200", "#ffffff", "#ff8200", "#ffffff", "#ff8200", "#ffffff", "#ff8200"),
        gradient = "radial",
        direction = "top"
      )
    ),
    
    
    
    titlePanel(title = h3("How many clicks in 5 seconds!!!", align = "center")),
    
    
    
    br(),
    br(),
    
    
    
    mainPanel(
      width = 12, align = "center", actionButton(
        inputId = "Timer",
        label = "Start Timer"
      ),
      actionButton(
        inputId = "Clicks",
        label = "Click Me"
      ),
      actionButton(
        inputId = "DisplayClicks",
        label = "How Many Times Did I Click?"
      )
    ),
    
    
    
    br(),
    br(),
    
    
    
    h3(textOutput("currentTime"), align = "center"),
    mainPanel(width = 12, align = "center", a(
      href = "https://haslam.utk.edu/experts/brian-stevens",
      "Learn more about the creator", align = "center"
    )),
    
    
    
    uiOutput("Eggs"),
    
    
    
    br(),
    
    
    
    h3(textOutput("DisplayingClicks"),align="center")
    
  )



#######################################################################
#######################################################################



server <- function(input, output, session) {
  timer <- reactiveVal(6)
  active <- reactiveVal(FALSE)

  
  

  ClickCounter <- reactiveValues(NumberClicks = 0)
  observeEvent(input$Timer, {
    ClickCounter$NumberClicks <- 0
  })
  
  
  
  observeEvent(input$Clicks, {
    ClickCounter$NumberClicks <- ClickCounter$NumberClicks + 1
  })
  
  
  
  observeEvent(input$DisplayClicks,{output$DisplayingClicks<-renderText({ClickCounter$NumberClicks})})

  
  
  observe({
    invalidateLater(1000, session)
    isolate({
      if (active()) {
        timer(timer() - 1)
        output$Eggs <- renderUI({
          isolate({
            if (2 == 2) {
              mainPanel(
                align = "center",
                width = 12,
                setBackgroundColor(
                  color = c(palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)], palette1[sample(1:50, 1)]),
                  gradient = "radial",
                  direction = "bottom"
                )
              )
            }
          })
        })
        if (timer() < 1) {
          active(FALSE)
          showModal(modalDialog(
            title = "Important Message",
            div(
              "Countdown completed! You clicked the button",
              paste(ClickCounter$NumberClicks), "times!"
            )
          ))
        }
      }
    })
  })

  
  
  # observers for actionbuttons

  

  observeEvent(input$Timer, {
    play(load.wave("FCW.wav"))
    active(TRUE)
    timer(5)
    output$DisplayingClicks<-renderText("")
  })



  output$currentTime <- renderText({
    invalidateLater(1000, session)
    if (as.numeric(seconds_to_period(timer())) >= 5) {
      paste("It's the final countdown!")
    } else {
      paste(
        "Hurry! You've only got",
        as.numeric(seconds_to_period(timer())),
        "seconds left!"
      )
    }
  })
}



shinyApp(ui = ui, server = server)
