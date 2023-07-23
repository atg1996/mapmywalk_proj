# Function to parse TCX data
parseTCXData <- function(file) {
  tcx <- readTCX(file$datapath, timezone = "GMT")
  
  # Extract distance and time information from TCX data
  time <- tcx$time
  distance <- tcx$distance
  
  # Create a data frame with the extracted information
  data <- data.frame(Time = time, DistanceMeters = distance)
  return(data)
}

readMapMyWalkCSV <- function(file_path) {
  df <- read.csv(file_path, stringsAsFactors = FALSE)
  return(df)
}

# Function to extract GPS data from MapMyWalk data
extractGPSData <- function(data) {
  gps_data <- data %>%
    select(latitude, longitude) %>%
    filter(!is.na(latitude) & !is.na(longitude))
  
  return(gps_data)
}

# Define Server
server <- function(input, output) {
  observeEvent(input$file, {
    req(input$file$datapath)  # Check if a file is uploaded
    tcx_data <- readTCX(input$file$datapath)  # Replace readTCX with your own function to read TCX data
    gps_data <- extractGPSData(tcx_data)  # Replace extractGPSData with your own function to extract GPS data
    
    # Plot the GPS data on the map
    output$map <- renderLeaflet({
      leaflet() %>%
        addProviderTiles(provider = "OpenStreetMap") %>%
        addPolylines(data = gps_data, 
                     lat = ~latitude, 
                     lng = ~longitude, 
                     color = "red", 
                     weight = 3)
    })
  })
  
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
