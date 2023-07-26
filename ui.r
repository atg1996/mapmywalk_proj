ui <- tagList(
  tags$head(
    tags$style(HTML("
      .col-sm-4 {flex: 0 0 33.33333%; max-width: 33.33333%;}
      .col-sm-8 {flex: 0 0 66.66667%; max-width: 66.66667%;}
    "))
  ),
  fluidPage(
    titlePanel("Walking Data Analysis"),
    sidebarLayout(
      sidebarPanel(
        fileInput("file", "Upload TCX file"),
        leafletOutput("map"),
        width = 4
      ),
      mainPanel(
        fluidRow(
          column(width = 6,
                 plotOutput("distance_plot")
                 
          ),
          column(width = 6,
                 plotOutput("density_plot_ggplot")  # Display the ggplot density plot here
                 
          )
        ),
        fluidRow(
          column(width = 6,
                 
          ),
        )
      )
    )
  )
)
