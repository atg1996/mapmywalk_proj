
ui <- fluidPage(
  titlePanel("TCX Data Analysis"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload TCX file")
    ),
    mainPanel(
      plotOutput("distance_plot")
    )
  )
)