# Function to parse TCX data
parseTCXData <- function(file) {
  tcx <- read_xml(file$datapath)
  
  # Extract distance and time information from TCX data
  time <- xml_find_all(tcx, "//Trackpoint/Time") %>%
    xml_text() %>%
    as.POSIXct(format = "%Y-%m-%dT%H:%M:%S", tz = "UTC")
  
  distance <- xml_find_all(tcx, "//Trackpoint/DistanceMeters") %>%
    xml_text() %>%
    as.numeric()
  
  # Create a data frame with the extracted information
  data <- data.frame(Time = time, DistanceMeters = distance)
  return(data)
}

# Define Server
server <- function(input, output) {
  
  # Generate distance over time plot
  output$distance_plot <- renderPlot({
    req(input$file)
    
    data <- parseTCXData(input$file)
    
    ggplot(data, aes(x = Time, y = DistanceMeters)) +
      geom_line() +
      labs(x = "Time", y = "Distance (Meters)") +
      theme_minimal()
  })
}
