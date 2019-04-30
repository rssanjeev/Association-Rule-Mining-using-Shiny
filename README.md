# Association-Rule-Mining-using-Shiny
Analyze the AdultUCI dataset using arules package and present the findings through a Shiny App

In this report we will be performing Association Rules Mining (ARM) on one of the in-built datasets in R called the __'AdultUCI'__ to predict the income range and the corresponding factors causing the outcome. We will also be experimenting with the algorithm by changing the parameters through a Shiny App, the link to which is provided at the end of this report. (Or feel free to and have fun with the app!)

## You can find the Shiny App here:
 https://saramasa.shinyapps.io/IST_HW1/

##### **Data Loading:**

```{r,eval=TRUE, results='hide', message=FALSE, warning=FALSE}
library(tidyr)
library(tidyverse)
library(caret)
library(arules)
library(arulesViz)
library(ggplot2)
library(plotly)
library(gridExtra)
library(dplyr)
```
Once the required libraries are loaded, we can go ahead and intialize the dataset & inspect the structure of the dataset using the following code chunk:

```{r}
data("AdultUCI")
data<-AdultUCI
str(data)
```

```{r}
summary(data)
```
