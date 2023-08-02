# Load required libraries
library(sf)
library(leaflet)
library(ggplot2)

# Load Yerevan city's shapefile data (replace the file path with your own)
yerevan_shapefile <- st_read('/cloud/project/Data/Yerevan-Districts/Yerevan-Districts.shp')
str(yerevan_shapefile)
ggplot(data = yerevan_shapefile) + geom_sf()

generated_points <- function(num_points, Min_Max_Long_Lat) {
  min_lon <- Min_Max_Long_Lat[1]
  min_lat <- Min_Max_Long_Lat[2]
  max_lon <- Min_Max_Long_Lat[3]
  max_lat <- Min_Max_Long_Lat[4]
  # getting generating random points' longitude and latitude
  random_lon <- round(runif(num_points, min_lon, max_lon), 8)
  random_lat <- round(runif(num_points, min_lat, max_lat), 8)
  #creating matrix
  random_points <- cbind(random_lon, random_lat)
  return(random_points)
}

Min_Max_Long_Lat <- c(44.410142296307456, 40.07754451731434, 
                      44.598430379441, 40.23416418967629)
Data <- generated_points(50000, Min_Max_Long_Lat)

map <- leaflet(yerevan_shapefile) %>%
  addPolygons() %>%
  addCircleMarkers(data = Data, 
                   # Add the random points to the map
                   radius = 0.75, 
                   color = "purple",           # Marker color
                   fillOpacity = 0.2)       # Marker fill opacity

# Display the map
map

  
  
  
