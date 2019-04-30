library(shiny)
library(ggplot2)

#data("AdultUCI")
#data<-AdultUCI

#for(i in c(1,3,5,11,12,13)) {data[i] <- lapply(data[i], as.numeric)}

fluidPage(
  
  titlePanel("Association Rules Mining", tags$head()),
  
  sidebarPanel(
    
    sliderInput('sup', "Support", min = 0.001, max = 1, value = 0.25, step = 0.005),
    
    sliderInput('conf', 'Confidence', min = 0.01, max =1, value = 0.25, step = 0.005),
    
    sliderInput('len', 'Minimum Rule Length', min = 1, max =15, value = 3, step = 1),
    
    sliderInput('mlen', 'Maximum Rule Length', min = 1, max =15, value = 7, step = 1),
    
    sliderInput('time', 'Maximum Time Taken', min = 1, max =25, value = 3, step = 1)
    
   
  ),
  
  mainPanel(
    tabsetPanel(id = 'mytab',
                tabPanel('Rules', value = 'datatable', dataTableOutput("rules")),
                tabPanel('Plot', value = 'graph',plotOutput('plot')))
  )
)