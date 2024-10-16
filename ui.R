#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that render a credit rating score
fluidPage(

    # Application title
    titlePanel("What's my credit rating score?"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            helpText("Please input your personal data:"),
            sliderInput("income",
                        "Income in USD:",
                        min = 0,
                        max = 15000,
                        value = 1500),
        sliderInput("age",
                    "Age:",
                    min = 18,
                    max = 100,
                    value = 45),
        sliderInput("education",
                    "Education:",
                    min = 5,
                    max = 20,
                    value = 15),
        selectInput("gender",
          "Gender:",
            choices = list("Male" = "Male", "Female" = "Female"),
          selected = 1
        ),
        
        selectInput("student",
                    "Student:",
                    choices = list("Yes" = "Yes", "No" = "No"),
                    selected = 1
        ),
        
        selectInput("married",
                    "Married:",
                    choices = list("Yes" = "Yes", "No" = "No"),
                    selected = 1
        ),
        
        numericInput("balance", "Account Balance", value = 1000),
        
        radioButtons(
          "etnicity",
          "Etnicity",
          choices = list("African American" = "African American", 
                         "Asian" = "Asian", 
                         "Caucasian" = "Caucasian"),
          selected = "Caucasian", choiceValues = "Caucasian", choiceNames = "Caucasian"
        )
        
        
    ),

        # Show a plot of the generated distribution
        mainPanel(
          
            plotOutput("distPlot"),
            textOutput("text0"),
            actionButton("Add", "Update"),
            textOutput("text1"),
            tableOutput('table1')
        )
    )
)
