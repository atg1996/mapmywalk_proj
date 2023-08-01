# Function to parse TCX data
parseTCXData <- function(file) {
  tcx <- readTCX(file, timezone = "GMT")
  
  # Calculate the minimum starting time among all TCX files
  min_time <- min(tcx$time)
  
  # Adjust the Time values by subtracting min_time
  tcx$time <- tcx$time - min_time
  
  time <- tcx$time
  distance <- tcx$distance
  altitude <- tcx$altitude
  
  data <- data.frame(Time = time, DistanceMeters = distance, Altitude = altitude)
  return(data)
}


readMapMyWalkCSV <- function(file_path) {
  df <- read.csv(file_path, stringsAsFactors = FALSE)
  str(df)
  return(df)
}

# Function to extract GPS data from MapMyWalk data
extractGPSData <- function(data) {
  gps_data <- data %>%
    select(latitude, longitude) %>%
    filter(!is.na(latitude) & !is.na(longitude))
  
  return(gps_data)
}


server <- function(input, output) {

  
  output$distance_plot <- renderPlot({
    req(input$files)
    
    # Combine data from all TCX files
    combined_data <- do.call(rbind, lapply(input$files$datapath, function(file_path) {
      data <- parseTCXData(file_path)
      data$File <- basename(file_path)  # Add a column to identify the file
      return(data)
    }))
    
    ggplot(combined_data, aes(x = Time, y = DistanceMeters, color = File)) +
      geom_line() +
      labs(x = "Time", y = "Distance (Meters)", title = "Distance passed over time") +
      theme_bw()
  })
  
  # Generate altitude over time plot for multiple files
  output$altitude_plot <- renderPlot({
    req(input$files)
    combined_data <- do.call(rbind, lapply(input$files$datapath, function(file_path) {
      data <- parseTCXData(file_path)
      data$File <- basename(file_path)
      return(data)
    }))
    ggplot(combined_data, aes(x = Time, y = Altitude, color = File)) +
      geom_line() +
      labs(x = "Time", y = "Altitude (Meters)", title = "Change of altitude during walk") +
      theme_bw()
  })
  
  # Generate density plot for multiple files
  output$density_plot_ggplot <- renderPlot({
    req(input$files)
    combined_data <- do.call(rbind, lapply(input$files$datapath, function(file_path) {
      data <- parseTCXData(file_path)
      data$File <- basename(file_path)
      return(data)
    }))
    ggplot(combined_data, aes(x = Time, y = DistanceMeters, color = File)) +
      geom_density_2d() +
      labs(x = "Time", y = "Distance (Meters)", title = "Density Plot of GPS Points") +
      theme_bw()
  })
  
  # Generate pace plot for multiple files
  output$pace_plot <- renderPlot({
    req(input$files)
    combined_data <- do.call(rbind, lapply(input$files$datapath, function(file_path) {
      data <- parseTCXData(file_path)
      data$DistanceCovered <- c(0, diff(data$DistanceMeters))
      data$File <- basename(file_path)
      return(data)
    }))
    
    combined_data$File <- factor(combined_data$File)  # Convert File to a factor
    
    ggplot(combined_data, aes(x = Time, y = DistanceCovered, group = File, color = File)) +
      geom_point() +
      geom_line() +
      labs(x = "Time", y = "Distance Covered (Meters)", title = "Distance Covered between neighbor Points") +
      theme_bw()
  })
  
  #functionality connected with map generation
  observeEvent(input$files, {
    req(input$files)
    map <- leaflet() %>%
      addProviderTiles(provider = "Esri.WorldGrayCanvas")
    
    for (file_path in input$files$datapath) {
      tcx_data <- readTCX(file_path)
      gps_data <- extractGPSData(tcx_data)
      map <- map %>%
        addPolylines(data = gps_data, lat = ~latitude, lng = ~longitude, 
                     color = sample(rainbow(length(input$files$datapath))), weight = 3) %>%
        addMarkers(lat = gps_data$latitude[1], lng = gps_data$longitude[1], label = "Start",
                   icon = leaflet::makeIcon(iconUrl = "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png")) %>%
        addMarkers(lat = gps_data$latitude[nrow(gps_data)], lng = gps_data$longitude[nrow(gps_data)], label = "End",
                   icon = leaflet::makeIcon(iconUrl = "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png"))
      
    }
      
    output$map <- renderLeaflet({ map })
  })
  }
