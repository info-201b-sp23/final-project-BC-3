library(ggplot2)
library(plotly)
library(dplyr)
library(stringr)
library(tidyverse)
library(bslib)

df <- read.csv("depression_anxiety_data.csv")


server <- function(input, output) {
  
  
  output$char2 <- renderPlotly({

    mean_of_each_score <- df %>% 
      group_by(school_year) %>% 
      summarize(Epworth_score = mean(epworth_score, na.rm = TRUE), 
                PHQ_score = mean(phq_score, na.rm = TRUE), 
                GAD_score = mean(gad_score, na.rm = TRUE)) %>% 
      pivot_longer(!school_year,
                   names_to = "type_of_scores",
                   values_to = "amount") %>% 
      filter((type_of_scores %in% input$type),
             (school_year %in% input$year))
    
    #graph 
    chart2 <- ggplot(data = mean_of_each_score ) +
      geom_col(aes(x = school_year,
                   y= amount,
                   fill = type_of_scores),
               position = "dodge") +
      labs(title = "Average Epworth, GAD, PHQ Scores for Each School Year", 
           x = "School Year", 
           y = "Scores")
    
    return(chart2)
    
  })
  
}