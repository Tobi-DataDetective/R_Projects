library(shiny)
shinyUI(fluidPage(
  titlePanel("NORTHWIND ANALYSIS"),
  sidebarLayout(
    sidebarPanel(
      selectInput("table","view table...",choices = c("customers","employee privileges","employees","inventory transactions","inventory transaction types","invoices","order details","order details status","order status","orders","order tax status","post","privileges","product","purchase order details","purchase order status","purchase orders","shippers","suppliers"))
      
    ),
    mainPanel(
      tabsetPanel(type="tab",
                  tabPanel("table",br(),tableOutput("table"))
      )
    )
  )
))
