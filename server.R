library(ggplot2)
library(plotly)
library(dplyr)
library(stringr)
library(tidyverse)
library(bslib)
library(jsonlite)

df <- read.csv("depression_anxiety_data.csv")


server <- function(input, output) {
  
  output$chart1 <- renderPlotly({
    
    # Get the frequency of each depression severity of both female and male
    frequency <- df %>% 
      group_by(depression_severity, gender) %>% 
      summarize(count = n()) %>% 
      filter(gender %in% input$gender)
    
    # Plot chart of gender vs depression severity
    chart1 <- ggplot(data = frequency, aes(x = depression_severity, y = count, fill = gender)) +
      geom_bar(stat = "identity", position = position_dodge(), alpha = 0.75) +
      labs(title = "Gender vs. Depression Severity", x = "Depression Severity", y = "Frequency", color = "Gender")
    
    return(chart1)
  })
  
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
  
  filteredData <- reactive({
    if (input$school == "All") {
      df_filtered <- df
    } else {
      df_filtered <- df %>% filter(school_year == input$school)
    }
    df_filtered
  })
  
  output$chart3 <- renderPlotly({
    severity_counts <- filteredData() %>% count(depression_severity)
    total_count <- sum(severity_counts$n)
    
    severity_counts <- severity_counts %>%
      mutate(percentage = n/total_count * 100)
    
    plot_ly(severity_counts, labels = ~depression_severity, values = ~percentage, type = "pie") %>%
      layout(title = "Distribution of Depression Severity by School Year",
             xaxis = list(title = "Severity Type"),
             yaxis = list(title = "Percentage"),
             showlegend = TRUE)
  })
  
}