ui <- tagList(
  tags$head(
    tags$style(HTML("
      .col-sm-4 {flex: 0 0 33.33333%; max-width: 33.33333%;}
      .col-sm-8 {flex: 0 0 66.66667%; max-width: 66.66667%;}
    "))
  ),
  fluidPage(
    titlePanel("TCX Data Analysis"),
    sidebarLayout(
      sidebarPanel(
        fileInput("file", "Upload TCX file"),
        width = 4
      ),
      mainPanel(
        plotOutput("distance_plot"),
        leafletOutput("map"),
        width = 8
      )
    )
  )
)