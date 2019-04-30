library(shiny)
library(rsconnect)
library(dplyr)
library(tidyr)
library(tidyverse)
library(caret)
library(arules)
library(arulesViz)
library(ggplot2)
#rsconnect::setAccountInfo(name='saramasa', token='4A6438C9ECBF99F2CB2505CC9EEC1D4E', secret='KnAECFHyzxZhreseycqWzbVRGCM/5zg81Fua10dd')
data("AdultUCI")
data <- AdultUCI

data <- data[!is.na(data$income),]
sum(is.na(data))

data$workclass[is.na(data$workclass)] <- "Never-worked"
data$`native-country`[is.na(data$`native-country`)] <- "United-States"
levels(data$occupation)<- c(levels(data$occupation), "Unknown")
data$occupation[is.na(data$occupation)] <- "Unknown"

data <- data[!duplicated(data),]
#data <- data[with(data, order(occupation)),]

#tail(data, 1843)
#nrow(data)-sum(is.na(data))
#data[30719:30849,7]  <- "Adm-clerical"
#data[30850:30980,7]  <- "Armed-Forces"
#data[30981:31111,7]  <- "Craft-repair"
#data[31112:31242,7]  <- "Exec-managerial"
#data[31243:31373,7]  <- "Farming-fishing"
#data[31374:31504,7]  <- "Handlers-cleaners"
#data[31505:31635,7]  <- "Machine-op-inspct"
#data[31636:31766,7]  <- "Other-service"
#data[31767:31897,7]  <- "Priv-house-serv"
#data[31898:32028,7]  <- "Transport-moving"
#data[32029:32159,7]  <- "Protective-serv"
#data[32160:32290,7]  <- "Sales"
#data[32291:32421,7]  <- "Tech-support"
#data[32422:32561,7]  <- "Prof-specialty"

for(i in c(1,3,5,11,12,13)) {data[i] <- lapply(data[i], as.numeric)}

data$age <- discretize(data$age, method = "frequency", breaks = 3, 
                       labels = c("young", "adult", "old"), order = T)
data$fnlwgt <- discretize(data$fnlwgt, method = "frequency", breaks = 5, 
                          labels = c("lower","low", "medium", "high", "higher"), order = T)
data$`education-num` <- discretize(data$`education-num`, method = "frequency", breaks = 3, 
                                   labels = c("low", "medium", "high"), order = T)
data$`capital-gain` <- discretize(data$`capital-gain`, method = "interval", breaks = 5, 
                                  labels = c("lower","low", "medium", "high", "higher"), order = T)
data$`capital-loss` <- discretize(data$`capital-loss`, method = "interval", breaks = 4, 
                                  labels = c("low", "medium", "high", "higher"), order = T)
data$`hours-per-week` <- discretize(data$`hours-per-week`, method = "interval", breaks = 5, 
                                    labels = c("lower","low", "medium", "high", "higher"), order = T)

function(input, output){
  
  
  rules <- reactive(
    {
      
      income_rules <- apriori(data=data, parameter=list (supp= as.numeric(input$sup),conf = as.numeric(input$conf) , minlen= as.numeric(input$len)+1, maxlen = as.numeric(input$mlen),
                                                         maxtime=as.numeric(input$time), target = "rules"), appearance = list (rhs=c("income=large", "income=small")))
    }
  )
  
  output$plot <- renderPlot({
    
    income_rules <-rules()
    
    p <- plot(income_rules)
    
    print (p)
    }, height = 600)
  
  output$rules <- renderDataTable( {
    
    income_rules <- rules()
    
    rulesdf <- DATAFRAME(income_rules)
    rulesdf
    #inspect(head(sort(income_rules, by='confidence'),10))

    
  })
  

  }