#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Cancer Prediction Module"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       numericInput("rm","radius_mean",value=0),
       numericInput("tm","texture_mean",value=0),
       numericInput("pm","perimeter_mean",value=0),
       numericInput("am","area_mean",value=0),
       numericInput("sm","smoothness_mean",value=0),
       numericInput("cm","compactness_mean",value=0),
       numericInput("cnm","concavity_mean",value=0),
       numericInput("cpm","concave.points_mean",value=0),
       numericInput("sym","symmetry_mean",value=0),
       numericInput("fm","fractal_dimension_mean",value=0),
       numericInput("rse","radius_se",value=0),
       numericInput("tse","texture_se",value=0),
       numericInput("pse","perimeter_se",value=0),
       numericInput("ase","area_se",value=0),
       numericInput("sse","smoothness_se",value=0),
       numericInput("cse","compactness_se",value=0),
       numericInput("cnse","concavity_se",value=0),
       numericInput("cpse","concave.points_se",value=0),
       numericInput("syse","symmetry_se",value=0),
       numericInput("fse","fractal_dimension_se",value=0),
       numericInput("rw","radius_worst",value=0),
       numericInput("tw","texture_worst",value=0),
       numericInput("pw","perimeter_worst",value=0),
       numericInput("aw","area_worst",value=0),
       numericInput("sw","smoothness_worst",value=0),
       numericInput("cw","compactness_worst",value=0),
       numericInput("cnw","concavity_worst",value=0),
       numericInput("cpw","concave.points_worst",value=0),
       numericInput("syw","symmetry_worst",value=0),
       numericInput("fw","fractal_dimension_worst",value=0)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      h1(textOutput("out"),align="center")
       
    )
  )
))
