# Load required libraries
library(sf)
library(leaflet)

# Load Yerevan city's shapefile data (replace the file path with your own)
yerevan_shapefile <- st_read('/cloud/project/Yerevan-Districts.shp', quite = T)

# Function to generate random points within a specified bounding box
generate_random_points_within_boundary <- function(num_points, shapefile) {
  # Extract minimum and maximum latitude and longitude from the shapefile data
  min_lon <- min(shapefile$lon)
  min_lat <- min(shapefile$lat)
  max_lon <- max(shapefile$lon)
  max_lat <- max(shapefile$lat)
  
  # Generate random longitude and latitude coordinates
  random_lon <- runif(num_points, min_lon, max_lon)
  random_lat <- runif(num_points, min_lat, max_lat)
  
  # Combine longitude and latitude into a matrix
  random_points <- cbind(random_lon, random_lat)
  
  return(random_points)
}

# Example usage
# Generate 100 random points within the Yerevan city boundary
num_points <- 100
random_points <- generate_random_points_within_boundary(num_points, yerevan_shapefile)

# Convert the random points matrix to a spatial data frame
random_points_df <- data.frame(lon = random_points[, 1], lat = random_points[, 2])
coordinates(random_points_df) <- c("lon", "lat")
st_crs(random_points_df) <- st_crs(yerevan_shapefile)  # Set the same CRS as the shapefile

# Create the leaflet map
map <- leaflet(yerevan_shapefile) %>%
  addPolygons() %>%
  addCircleMarkers(data = random_points_df,  # Add the random points to the map
                   radius = 5,              # Marker size
                   color = "red",           # Marker color
                   fillOpacity = 0.8)       # Marker fill opacity

# Display the map
map
