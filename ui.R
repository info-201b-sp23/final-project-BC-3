library(dplyr)
library(stringr)
library(tidyverse)
library(bslib)
library(shiny)
library(ggplot2)
library(plotly)
library(shinythemes)

df <- read.csv("depression_anxiety_data.csv")

#chart2 dataframe
mean_of_each_score <- df %>% 
  group_by(school_year) %>% 
  summarize(Epworth_score = mean(epworth_score, na.rm = TRUE), 
            PHQ_score = mean(phq_score, na.rm = TRUE), 
            GAD_score = mean(gad_score, na.rm = TRUE)) %>% 
  pivot_longer(!school_year,
               names_to = "type_of_scores",
               values_to = "amount") 



#App

my_theme <- bs_theme(
  bg = "#EBF5FB",
  fg = "black",
  primary = "#1A5276"
) %>% bs_add_rules(sass::sass_file("style.scss"))


Intro_tab <- tabPanel("Introduction",
                      h1("Depression Demogrphic of college students", id = "1"),
                      img(src = "Early-Warning-Signs.png", height = '500px', width = '900px', align = "center"),
                      h3("Introduction", id = "introduction"),
                      p("1. Does the severity of depression vary based on demographic on gender?", align = "center", id = "q1"),
                      p("2. WHat is the relationship between anxiety, depression and sleepiness with different school grade? ", align = "center", id = "q2"),
                      p("3. Do depression levels vary based on the grade level of college students?", align = "center", id = "q3"),
                      p(" These research questions are motivated by the need to understand the distribution of depression among college students. Depression is a common mental health issue that impacts a lot of the population. A high rate of depression is among young adults, especially college students. The questions provide significant information about particular demographics and grades that are most affected by depression and whether the severity of depression varies based on demographics on gender. This information can be helpful in understanding which demographic group is the most affected by depression and how mental health services can better provide their services. The research question also includes whether depression levels vary based on the grade level of college students. This question could help us identify the key factors that contribute to depression and find an approach that could help the students. Overall having this information will help identify the specific groups that require more in-depth treatment and support. These questions are important and relate to our data set and answer important questions individuals may have about the dataset.
", id = "intro_p"),
                      
                      h3("Related Work", id = "related_work"),
                      a("College students’ anxiety, depression higher than ever, but so are efforts to receive care. Michigan News, University of Michigan.", href = "https://news.umich.edu/college-students-anxiety-depression-higher-than-ever-but-so-are-efforts-to-receive-care/", id = "s1"),
                      p(""),
                      a("Depression in women: Understanding the gender gap.", href = "https://www.mayoclinic.org/diseases-conditions/depression/in-depth/depression/art-20047725", id = "s2"),
                      p(""),
                      a("Depression, anxiety and stress in different subgroups of first-year university students from 4-year cohort data. Science Direct.", href = "https://www.sciencedirect.com/science/article/pii/S016503271933157X", id = "s3"),
                      p(""),
                      p("The topic we are researching is depression and anxiety. Depression and anxiety is a common and serious medical illness that can affect an individual’s emotions, thoughts, and behaviours. The number of depression and anxiety levels among students in college has been increasing. According to a recent article by the University of Michigan, it is reported that based on web surveys taken by 96,000 U.S. students across 133 campuses in the 2021-22 academic year, it is found that 44% of students reported symptoms of depression, which represents the highest recorded rates in the history of the 15-year-old survey, indicating a significant rise in student depression. In fact, different people might have different levels of depression and anxiety, and there are many factors affecting them. According to the article ‘Depression in Women: Understanding the gender gap’ by Mayo Clinic, it is nearly twice as likely for women to be diagnosed with depression compared to men due to puberty, premenstrual problems, pregnancy, and many more. Different individuals may experience varying levels of depression and anxiety. One significant factor that affects students’ mental well-being is their study load. According to a research study about ‘Depression, anxiety and stress in different subgroups of first-year university students from 4-year cohort data’, it is mentioned that for overall groups of students, study load was related positively to depression. This emphasizes that students with heavier study loads are more likely to experience depression.", id = "rw_p"),
                      
                      h3("Data Analyze", id = "da"),  
                      a("Depression and anxiety data", href = "https://www.kaggle.com/datasets/shahzadahmad0402/depression-and-anxiety-data", id = "da_1"),
                      p("The data was collected from Shahzad Ahmed BJUT, and it was collected from undergraduate students of the University of Lahore. Data have been collected to find out which demographic depression affects the studies and social behaviour of the students. 783 observations and 19 features are in the data.", id = "da_p1"),
                      p("As the data includes sensitive information about mental health, the privacy and confidentiality of the participants must be respected.", id = "da_p2"),
                      p(" However, this data may have some limitations. First, the dataset is based on undergraduate students from some parts of Lahore University, so it does not represent more university students. Thus, the results of this data are limited in terms of generalization. Similarly, due to the limited sample size, it may be insufficient to detect stronger results and subtle, detailed patterns. If the sample size were larger, more accurate results could be obtained. Furthermore, if other important variables that may affect the relationship between depression and academic/social behaviours were included, more positive results could be obtained. The dataset only includes data on depression and anxiety, which are complex mental health conditions that a wide range of factors can influence. Without a more comprehensive set of variables, it may be difficult to predict or diagnose depression and anxiety accurately. The data is self-reported, which means that the accuracy of the information may be influenced by factors such as social desirability bias, recall bias, or misunderstanding of the questions. For example, information on whether participants in this dataset had received treatment for depression or anxiety and what type of treatment they had received is not included. If such features had been included, effective research on various treatment methods could have been conducted.", id = "da_p3"),
                      
                      h3("Implicaition", id = "im"),
                      p("Through the demographics that we learned from our research, it is possible for the experts to develop a better environment for college students. Many students suffer from depression, and knowing the demographic of college students will help in designing and implementing the interventions that can support students’ mental health. Different technological methods can be applied to classify more deeply the severity of depression, anxiety, and other mental disorders. It will help to identify the common patterns that can inform the targeted interventions. The policymakers can use the information from the study to inform existing policies and programs that are focused on promoting mental health and depression in colleges. It can also provide a base for new policies and programs that can help with students’ mental health. All of the implications will lead to better mental health outcomes for college students and make a huge contribution to each of the student’s academic success and overall health.", id = "im_p"),
                      
                      h3("Limitations", id = "lim"),
                      p("The challenges or limitations we might need to address with our project idea more broadly is that this project could ensure the accuracy and reliability of the dataset, given that it was collected from only one university and may not be representative of the broader population. The population from which the data was collected needs to be more diverse. The dataset we selected was collected from undergraduate students of the University of Lahore, which means that this data represents only a limited portion of all students nationwide who may have depression. Therefore, the results of this dataset may introduce biases towards depression among students from this university and cannot be generalized to students from other universities. To reduce bias in the data, it is necessary to expand the population to include students from multiple universities and randomly select the sample within that population. It is important to address these challenges and limitations with a responsible approach to data analysis and results.", id = "lim_p"),
)


gender_widget <-
  selectInput(
    inputId = "gender",
    label = "Select gender",
    choices = df$gender,
    selectize = TRUE,
    multiple = TRUE,
    selected = "male"
  )

chart1_main_panel <- mainPanel(
  plotlyOutput(outputId = "chart1"),
  br(),
  p("This chart shows the relation between gender and depression severity that was observed in University of Lahore."),
  h4("Purpose: "),
  p("This chart is used to analyze how does gender affect depression severity and analyze whether female or male has higher depression. Bar chart is also used to make it easier to visualize the data and make a comparison between female and male depression severity"),
  h4("Insights: "),
  p("From the chart above, we can see that there are 6 different levels of depression severity, including ‘Mild’, ‘Moderate’, ‘Moderately severe’, ‘none’, ‘None-minimal’, and ‘Severe’. By analyzing the chart above, I discovered that in general, female experiences more depression than male. We can see from the chart that there are higher number of female, which is 194, compare to male, which is 150, who experience mild depression. There are also more female , which is 86, compare to male, which is 54, who experience moderate depression. On the other hand, there are more male, which is 137, than female, which is 89, who experience none to minimal depression. There are also more male, which is 11, compare to female, which is 4, who don’t experience depression at all. This emphasizes that in general, female experiences higher depression severity compare to man.")
)

# Combine sidebar panel and main panel
chart1_tab <- tabPanel(
  # Title of the tab
  "Gender & Depression Severity",
  h1("Relation of gender with depression severity", align="center"),
  sidebarLayout(
    sidebarPanel(
      gender_widget),
    chart1_main_panel
  )
)

char2_widget <- 
  selectInput(inputId = "type",
              label = h4("Select Type of Score"),
              choices = mean_of_each_score$type_of_scores,
              selected = "Epworth_score",
              multiple = TRUE)


char2_widget2 <- 
  checkboxGroupInput(inputId = "year",
                     label = h4("Select School Year"),
                     choices = c("School year 1" = "1",
                                 "School year 2" = "2",
                                 "School year 3" = "3",
                                 "School year 4" = "4"),
                     selected = c("1", "2"))

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
                      h2("Average Epworth, GAD, PHQ Scores for Each School Year", align="center"),
                      sidebarLayout(
                        sidebarPanel(
                          char2_widget,
                          char2_widget2),
                      char2_mainpanel))




chart3_widget <- selectInput("school", 
                             "School Year", 
                             choices = unique(df$school_year), 
                             selected = "All")

chart3_mainpanel <- mainPanel(
  plotlyOutput("chart3"),
  p(" This pie chart shows the relation between schoolyear and depression severity 
    that was observed in University of Lahore. The purpose of this chart is to 
    calculate various summary statistics for the depression severity variable 
    grouped by the school years. This chart helps to view easier vizualization 
    with the data set.The chart attempts to answer the distribution of depression 
    severity across different school years By analyzing the pue chart, we can gain 
    insights into how the count of depression severity is distributed across 
    different school years, identify any potential patterns or variations, and 
    understand the relationship between these variables. The chart helps analyze 
    how depression severity varies across different school years and provides 
    interactivity by showing the exact proportion of each severity type when 
    hovering over a slice. In the provided chart, we can observe six distinct 
    levels of depression severity: ‘Mild’, ‘Moderate’, ‘Moderately severe’, ‘None’, ‘
    None-minimal’, and ‘Severe’. Insights: I noticed that the severity of mild 
    depression is consistently high across all school years, particularly among 
    freshmen. Additionally, moderate depression is also most prevalent among 
    freshman students.Furthermore, moderately severe depression is also highest 
    among freshmen, indicating that this group experiences the greatest severity
    of depression, with a value of 20. However, when we look through the moderately 
    severe and severe values, freshman has 8.73, sophomore as 7.81, juniors at  
    2.854 and seniors as 6.248. Through this we can see students suffer most in 
    freshman, and sophomore, followed ny seniors."))

chart3_tab <- tabPanel("Depression Severity by School Year",
                       h1("Distrivution of Depression Severity by Selected School Year.", align="center"),
                       sidebarLayout(
                         sidebarPanel(
                           chart3_widget),
                         chart3_mainpanel
                       ))

conclusion_tab <- tabPanel("Conclusion",
                           h1("Conclusion"),
                           br(),
                           h3("1. Takeaways"),
                           img(src = "chart1.png", height = '300px', width = '600px', align = "center"),
                           p(""),
                           p("The bar graph about gender and depression severity reveals several takeaways regarding the relationship between gender and depression severity. From the graph, we can see that there are more females who experience mild, moderate, and moderately severe levels of depression compared to males. This suggests that females are more prone to depression compared to males. There might be some factors related to this result, including earlier puberty in females, hormone differences, and other factors. Additionally, the graph also shows that there are a higher number of males who experience none and none-minimal depression severity compared to females. This indicates that more males experience low to no depression at all. In conclusion, these takeaways emphasise that, in general, female has a higher chance of experiencing depression compared to male."),
                           br(),
                           h3("2. Takeaways"),
                           img(src = "chart2.png", height = '300px', width = '600px', align = "center"),
                           p(""),
                           p("In conclusion, the bar chart that compares average Epworth, GAD, and PHQ scores for each school year from the University of Lahore provides several key takeaways. First, it shows that the second school year consistently exhibits the highest scores for Epworth (sleepiness), GAD (anxiety), and PHQ (depression). The first year also demonstrates relatively high scores, while years 3 and 4 display lower scores. This indicates that students in the earlier grades may experience more sleep issues, increased depression, and higher anxiety compared to their peers in later years. Furthermore, the chart reveals a positive relationship between the Epworth, GAD, and PHQ scores. Overall, 
                           these takeaways emphasise the importance of addressing sleep, depression, and anxiety concerns, especially for students in the first and second school years."),
                           br(),
                           h3("3. Takeaways"),
                           img(src = "chart3.png", height = '300px', width = '600px', align = "center"),
                           p(""),
                           p("The analysis of the pie charts reveals several key takeaways regarding the relationship between school years and depression severity among students at the University of Lahore. Firstly, freshman students consistently exhibit higher levels of depression severity compared to other school years. This finding emphasises the need for targeted mental health support and resources during the critical transition period from high school to university. Secondly, the prevalence of depression severity decreases as students progress through their school years, indicating the potential positive impact of becoming more familiar with the university environment and academic demands. Recognising the relationship between school year and depression severity can inform tailored interventions and support systems. Overall, these insights underscore the necessity for universities to prioritise mental health initiatives, provide early interventions for freshmen, and establish ongoing support throughout students' academic journeys."),
                           h3("Broader implications"),
                           p("The analysis reveals important insights about depression among college students at the University of Lahore. Freshman students exhibit higher depression severity, highlighting the need for targeted support during the transition period. As students progress, depression prevalence decreases, emphasizing the impact of becoming familiar with university life. Additionally, females are more prone to depression, highlighting the necessity for tailored interventions. These findings underscore the importance of prioritizing mental health, providing early interventions, and establishing ongoing support systems for students.")
                           )





ui <- navbarPage(
  theme = my_theme,
  "Depression Demogrphic of college students",
  Intro_tab,
  chart1_tab,
  char2_tab,
  chart3_tab,
  conclusion_tab
)



