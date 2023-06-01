library(shiny)
library(plotly)
library(dplyr)
library(jsonlite)

# Read the data
df <- read.csv("depression_anxiety_data.csv", stringsAsFactors = FALSE)

# Define the UI
ui <- fluidPage(
  titlePanel("Depression Severity by School Year"),
  sidebarLayout(
    sidebarPanel(
      selectInput("school", "School Year", choices = c("All", unique(df$school_year)), selected = "All"),
      p("The chart attempts to answer the distribution of depression severity across different school years."),
      p("It provides a visual representation of the proportion of each severity type ( mild, moderate, severe etc.) within a selected school year."),
      p("The chart helps analyze how depression severity varies across different school years and provides interactivity by showing the exact proportion of each severity type when hovering over a slice."),
      p("By selecting a specific school year using the sidebar input, the chart dynamically updates to display the distribution of severity types for that year.")
    ),
    mainPanel(
      plotlyOutput("chart")
    )
  )
)         