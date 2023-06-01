library(shiny)
library(plotly)
library(dplyr)
library(jsonlite)

# Read the data
df <- read.csv("depression_anxiety_data.csv", stringsAsFactors = FALSE)

# Define the server function
server <- function(input, output) {
  filteredData <- reactive({
    if (input$school == "All") {
      df_filtered <- df
    } else {
      df_filtered <- df %>% filter(school_year == input$school)
    }
    df_filtered
  })
  
  output$chart <- renderPlotly({
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


