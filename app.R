# app.R
# 1234
# Load the required libraries
library(shiny)

# Load the separate files
source("global.R")
source("ui.R")
source("server.R")

# Run the app
shinyApp(ui, server)