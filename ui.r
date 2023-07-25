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
        fluidRow(
          column(width = 6,
                 plotOutput("density_plot_ggplot")  # Display the ggplot density plot here
          ),
          column(width = 6,
                 leafletOutput("map")
          )
        ),
        fluidRow(
          column(width = 6,
                 plotOutput("distance_plot")
          ),
          column(width = 6,
                 # Add your ggplot graphs here using plotOutput
                 plotOutput("ggplot_graph1"),
                 plotOutput("ggplot_graph2"),
                 plotOutput("ggplot_graph3")
          )
        )
      )
    )
  )
)
