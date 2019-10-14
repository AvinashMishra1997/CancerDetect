#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source("~/CancerDetect/CancerDetection.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    
    
    # draw the histogram with the specified number of bins
    corrplot(corr_mat)
    
  })
  output$out<- renderPrint({
    to_pred <- list(radius_mean=input$rm,texture_mean=input$tm,perimeter_mean=input$pm,area_mean=input$am,smoothness_mean=input$sm,compactness_mean=input$cm,concavity_mean=input$cnm,concave.points_mean=input$cpm,symmetry_mean=input$sym,fractal_dimension_mean=input$fm,radius_se=input$rse,texture_se=input$tse,perimeter_se=input$pse,area_se=input$ase,smoothness_se=input$sse,compactness_se=input$cse,concavity_se=input$cnse,concave.points_se=input$cpse,symmetry_se=input$syse,fractal_dimension_se=input$fse,radius_worst=input$rw,texture_worst=input$tw,perimeter_worst=input$pw,area_worst=input$aw,smoothness_worst=input$sw,compactness_worst=input$cw,concavity_worst=input$cnw,concave.points_worst=input$cpw,symmetry_worst=input$syw,fractal_dimension_worst=input$fw)
    p1 <- predict(model_rf, to_pred)
    p2 <- predict(cart_model,to_pred)
    p3 <- predict(gbm_model, to_pred)
    
    if((p1[1]=="M") & (p2[1]=="M") & (p3[1]=="M")){
      "you need to consult a doctor"
    }else{
      "you are healthy for now"
    }
  })
  
})


