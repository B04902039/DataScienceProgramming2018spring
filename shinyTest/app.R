

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  tabsetPanel(
  tabPanel("Faithful", 
           # Application title
           titlePanel("Old Faithful Geyser Data"),
           # Sidebar with a slider input for number of bins 
           sidebarLayout(
             sidebarPanel(
               sliderInput("bins",
                           "Number of bins:",
                           min = 1,
                           max = 50,
                           value = 30),
               numericInput("bin2",'row of table', value = 5)
             ),
             
             
             # Show a plot of the generated distribution
             mainPanel(
               plotOutput("distPlot"),
               textOutput('text1'),
               plotOutput("distPlot2"),
               dataTableOutput("table1")
             )
           )),
  tabPanel("tab 2", "contents"),
  tabPanel("tab 3", "contents"))
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
   output$distPlot2 <- renderPlot({
      # generate a table of faithful
      row = input$bins+50
      x <- faithful[1:row,1]
      y <- faithful[1:row,2]
      plot(x, y)
   })
   output$text1 <- renderText(
     'dbah bahbh'
   )
   output$table1 <- renderDataTable({
     # generate a table of faithful
     x <- faithful[1:input$bin2,]
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

