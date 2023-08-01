ui <- tagList(
  tags$head(
    tags$style(HTML("
      .col-sm-4 {flex: 0 0 33.33333%; max-width: 33.33333%;}
      .col-sm-8 {flex: 0 0 66.66667%; max-width: 66.66667%;}
    "))
  ),
  fluidPage(
    tabsetPanel(
      tabPanel("Walking Data Analysis",
    sidebarLayout(
      sidebarPanel(
        fluidRow(
          column(width = 12,
                 fileInput("files", "Upload TCX files", multiple = TRUE),
                 leafletOutput("map"))
        ),
        fluidRow(
          column(width = 12,
                 h4("How the data is being analyzed?"),
                 
                 h6("One of the key objectives in urban planning is to assess
                 the pedestrian comfort levels concerning pavement conditions.
                 In this application, GPS data is meticulously analyzed and presented
                 through charts to facilitate insightful research. These charts
                 collectively furnish substantial information for comprehensive
                 examination.
                 "),
                 
                 h6("The first chart elucidates the correlation between time and
                 distance covered. A well-maintained pavement typically yields
                 a linear relationship in this graph, indicative of smooth and
                 uninterrupted pedestrian flow.
                 "),
                 
                 h6("The second chart illustrates the density of GPS points.
                 Observing peaks in this graph allows us to cross-reference
                 with the preceding chart to discern potential areas of concern,
                 such as road crossings or issues related to pavement quality."),
                 
                 h6("The third chart depicts the altitude gain during the walk,
                 an invaluable metric to consider, especially concerning
                 elderly individuals or persons with disabilities. Significant
                 altitude changes over short distances can pose significant
                 challenges, making this data critical for pedestrian accessibility
                 assessments.
                 "),
                 h6("The fourth chart provides a more detailed analysis of pace
                 variations during the walk, offering valuable insights into
                 pedestrian experience and pavement conditions. A relatively
                 constant pace indicates smoother walking with fewer intermittent
                 challenges related to the pavement. In contrast to the first chart,
                 which presents a broader overview and highlights major obstacles,
                 this graph delves into finer details, enabling a precise assessment
                 of pavement quality and its impact on pedestrian flow. This localized
                 information proves crucial for targeted interventions to enhance 
                 pedestrian comfort and safety.
                 ")),
                
        ),
      ),
      mainPanel(
        fluidRow(
          column(width = 6,
                 plotOutput("distance_plot")
                 
          ),
          column(width = 6,
                 plotOutput("density_plot_ggplot")
                 
          )
        ),
        fluidRow(
          column(width = 6,
                 plotOutput("altitude_plot")
                 
          ),
          column(width = 6,
                 plotOutput("pace_plot")
                 
          )
        )
      )
    )
  ),
  tabPanel("Walking Data Analysis")
    )
  )
)
