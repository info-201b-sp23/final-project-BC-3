library(dplyr)
library(stringr)
library(tidyverse)
library(bslib)
library(shiny)
library(ggplot2)
library(plotly)


df <- read.csv("depression_anxiety_data.csv")

mean_of_each_score <- df %>% 
  group_by(school_year) %>% 
  summarize(Epworth_score = mean(epworth_score, na.rm = TRUE), 
            PHQ_score = mean(phq_score, na.rm = TRUE), 
            GAD_score = mean(gad_score, na.rm = TRUE)) %>% 
  pivot_longer(!school_year,
               names_to = "type_of_scores",
               values_to = "amount") 


intro_tab <- tabPanel("Information",
                      h1("Introduction"),
                      img(src = "Early-Warning-Signs.png", height = '500px', width = '900px', align = "center")
)


char2_sidepanel <- sidebarPanel(
  h3("Options for graph"),
  selectInput(inputId = "type",
              label = h4("Select Type of Score"),
              choices = mean_of_each_score$type_of_scores,
              selected = "Epworth_score",
              multiple = TRUE),
  checkboxGroupInput(inputId = "year", 
                     label = h4("Select School Year"), 
                     choices = c("School year 1" = "1", 
                                    "School year 2" = "2", 
                                    "School year 3" = "3",
                                    "School year 4" = "4"),
                     selected = c("1", "2"))
  )

  
char2_mainpanel <- mainPanel(
  plotlyOutput(outputId = "char2"),
  br(),
  p("This chart represents the relationship between school year and different Epworth, 
  GAD, and PHQ scores that was observed in University of Lahore."),
  h4("Purpose: "),
  p("Grouped bar chart is used for this data in order to compare each of the school 
    year with different scores more easily. It is easier to look how each score 
    changes within each school year, and the relationship with each score. We can 
    see that the second school year has the highest Epworth score, GAD score, 
    and PHQ score."),
  h4("Insights: "),
  p("Epworth score is intended to measure the sleepiness. 0-10: normal range of 
    healthy adult, 11-14: mild sleepiness, 15-17: moderate sleepiness, 18-24: 
    severe sleepiness. GAD score represents the anxiety. 0-4: minimal anxiety, 
    5-9: mild anxiety, 10-14: moderate anxiety, 15 < score: severe anxiety. 
    The PHQ score represents the depression data. 0-4: normal or minimal depression, 
    5-9: mild depression, 10-14:moderate depression, 15-19: moderately severe depression, 
    20 < score: severe depression. The chart shows average score for each school year. 
    Followed by the first school year, it has the second highest Epworth score, 
    GAD score, and PHQ score. School year 3, and 4 seems to have lower scores 
    compared to the first and second school year. This lets us know more students 
    who are in 1 and 2 grade are likely to have less sleep, more depression, and 
    more anxiety compared to students in 3 and 4. Also we can conclude Epworth socre, 
    GAD score, and PHQ scores are positively related to each other.")
)

char2_tab <- tabPanel("Epworth, GAD, PHQ Scores",
                      h2("Average Epworth, GAD, PHQ Scores for Each School Year"),
                      char2_sidepanel,
                      char2_mainpanel
)
                      
  

ui <- navbarPage(
  "Depression Demogrphic of college students",
  intro_tab,
  char2_tab
)