# Random points generation.
generated_points <- function(num_points, Min_Max_Long_Lat) {
  
  min_lon <- Min_Max_Long_Lat[1]
  min_lat <- Min_Max_Long_Lat[2]
  max_lon <- Min_Max_Long_Lat[3]
  max_lat <- Min_Max_Long_Lat[4]
  
  # getting generating random points' longitude and latitude
  random_lon <- round(runif(num_points, min_lon, max_lon), 8)
  random_lat <- round(runif(num_points, min_lat, max_lat), 8)
  
  # creating matrix
  random_points <- cbind(random_lon, random_lat)
  
  return(random_points)
}

# Yerevan city min_max points
Min_Max_Long_Lat <- c(40.08854451731434, 44.428142296307456, 40.23416418967629, 44.598430379441)


num_points <- 100
random_points <- generated_points(num_points, Min_Max_Long_Lat)

print(random_points)

