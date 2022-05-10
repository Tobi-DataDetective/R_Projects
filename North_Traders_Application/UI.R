library(shiny)
shinyUI(fluidPage(
  titlePanel("NORTH WIND ANAYSIS"),
  sidebarLayout(
    sidebarPanel(("WHAT WOULD YOU LIKE TO ANALYZE?"),
                 textInput("NAME","ENTER NAME",""),
                 textInput("AGE","ENTER AGE","")),
    mainPanel(("DISPLAY OF INFORMATION"),
              textOutput("MYNAME"),
              textOutput("MYAGE")
  )
))