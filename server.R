#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {
  library(ISLR)
  library(tidyverse)
  data(Credit)
  Credit <- Credit %>% 
    select(-ID, -Limit, -Cards) %>% 
    mutate(Gender = factor(str_replace(Gender, " ", ""), levels = c("Male", "Female"))) 
  
    model <- Credit %>%  lm(Rating ~ ., data= .) 
  
  rv <- reactiveValues(
      data_points = data.frame(Income = as.integer(10000),
                                Age = as.integer(40),
                                Education = as.integer(10),
                                Gender = factor('Male', levels = c('Male', 'Female')),
                                Student = as.character('Yes'),
                                Married = as.character('Yes'),
                                Balance = as.numeric(1000),
                                Ethnicity = as.character("Caucasian")))
  rv1 <- reactiveValues(rating = 0)
  
  observeEvent(input$Add, {
    rv$data_points =  data.frame(
                            Income = input$income,
                            Age = input$age,
                            Education = input$education,
                            Gender = input$gender,
                            Student = input$student,
                            Married = input$married,
                            Balance = input$balance,
                            Ethnicity = input$etnicity)}
    
  )
  observeEvent(input$Add, {
    rv1$rating = predict(model,newdata = Credit %>% add_row(rv$data_points))})

#  
#  answer <- paste("Your score is", Income)
  string0 <- "Don't forget to run update after inputing your data. Else, you'll get an NA score!!!"
  string <- reactive(paste0("Hello your score is ", 
                            rv1$rating[nrow(Credit)+1] %>% round(), 
                            "\n ! Please check your input data below:"))
  
  
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        df = data.frame(
          x1 = Credit$Rating,
          y1 = predict(model,newdata = Credit))
 
        ggplot(df, aes(x=x1,y=y1)) +
          geom_point() +
          geom_abline(intercept = 0, slope = 1) +
          labs(title = "Quality of adjustment", x = "True Rating", y = "Prediction")



    })
    
    output$table1 <- renderTable({rv$data_points}) 
    output$text0 <- renderText(string0)
    output$text1 <- renderText(string())
}
