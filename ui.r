
ui <- fluidPage(
  titlePanel("TCX Data Analysis"),
  sidebarLayout(
    sidebarPanel(
        fileInput("file", "Upload TCX file"),
        style = "display: block;"
    ),
    
    mainPanel(
      tabsetPanel(id = "tabs",
                  type = "tabs",
                  tabPanel("MapMyWalk data Analysis", plotOutput("distance_plot")),
                  tabPanel("Walkability score calculator", plotOutput("plot1")),
                  tabPanel("Custom analysis TBD", plotOutput("plot")))
      
    )
  )
)