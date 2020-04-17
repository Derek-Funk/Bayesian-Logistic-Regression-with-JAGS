#library to deploy app: rsconnect
#command to deploy app: deployApp("C:\\Users\\derek.funk\\Desktop\\MSDS\\2019 Fall\\Bayesian\\Final Project\\4 - Presentation\\Breast_Cancer_JAGS")

source("global.R")

ui = navbarPage(title = "Cancer Bayesian Logistic", theme = shinytheme(theme = "cosmo"), useShinyjs(),
  tabPanel(title = "Background",
    includeHTML("www/background.html")         
  ),
  tabPanel(title = "Data",
    includeHTML("www/data.html")         
  ),
  tabPanel(title = "Model Visual",
    uiOutput(outputId = "modelVisual"),
    h3("Forward Selection based on Correlations"),
    fluidRow(
      column(width = 2,
        h5("predictors vs. Y"),
        tableOutput(outputId = "dependentCorrs")  
      ),
      column(width = 10,
        h5("among predictors"),
        tableOutput(outputId = "independentCorrs")       
      )
    )
  ),
  tabPanel(title = "Model Progression",
    column(width = 6,
      includeHTML("www/modelProgression.html")
    ),
    column(width = 6,
      HTML("<h3>Final Predictors</h3><br>
           <ul>
            <li>max # of concave points (shape)</li>
            <li>standard deviation of texture (varying color)</li>
            <li>max radius (size)</li>
           </ul>
           ")
    )
  ),
  tabPanel(title = "Model Diagnostics",
    box(
      tags$img(
        src = "model_5-Diagbeta0.png",
        height = "80%",
        width = "80%"
      )
    ),
    box(
      tags$img(
        src = "model_5-Diagbeta[1].png",
        height = "80%",
        width = "80%"
      )
    ),
    box(
      tags$img(
        src = "model_5-Diagbeta[2].png",
        height = "80%",
        width = "80%"
      )
    ),
    box(
      tags$img(
        src = "model_5-Diagbeta[3].png",
        height = "80%",
        width = "80%"
      )
    )
  ),
  tabPanel(title = "Model Interpretation",
    column(width = 6,
      box(width = 12,
        uiOutput(outputId = "modelVisual2")
      ),
      box(title = "-----------------------------------------------",
        uiOutput(outputId = "modelVisual2_1")
      ),
      box(title = "-----------------------------------------------",
        uiOutput(outputId = "modelVisual2_2")
      )
    ),
    column(width = 6,
      sliderInput(inputId = "x1", label = "X1", min = 0, max = 0.3, value = 0.15, step = 0.01),
      sliderInput(inputId = "x2", label = "X2", min = 0, max = 50, value = 25, step = 1),
      sliderInput(inputId = "x3", label = "X3", min = 0, max = 50, value = 25, step = 1),
      uiOutput(outputId = "logOdds")
    )
  ),
  tabPanel(title = "Summary",
    includeHTML("www/summary.html")
  )
)

server = function(input, output) {
  output$modelVisual = renderUI(expr = {
    withMathJax(
      "$$\\beta_0 \\sim Normal(0,0.5), \\quad \\beta_j \\sim Normal(0,0.5), \\quad \\alpha \\sim Beta(1,9)$$",
      "$$\\downarrow$$",
      "$$\\mu_i = logistic(\\beta_0 + \\sum_{j=1}^k \\beta_j x_{j,i}) (1 - \\alpha) + \\frac{1}{2} \\alpha$$",
      "$$\\downarrow$$",
      "$$y_i \\sim Bernoulli(\\mu_i)$$"
    )
  })
  
  output$dependentCorrs = renderTable(expr = {
    read.csv(file = "www/dependentCorrs.csv")
  })
  
  output$independentCorrs = renderTable(expr = {
    read.csv(file = "www/independentCorrs.csv")
  })
  
  output$modelVisual2 = renderUI(expr = {
    withMathJax(
      "$$\\beta_0 \\sim Normal(0,0.5), \\quad \\beta_j \\sim Normal(0,0.5), \\quad \\alpha \\sim Beta(1,9)$$",
      "$$\\downarrow$$",
      "$$\\mu_i = logistic(\\beta_0 + \\sum_{j=1}^3 \\beta_j x_{j,i}) (1 - \\alpha) + \\frac{1}{2} \\alpha$$",
      "$$\\downarrow$$",
      "$$y_i \\sim Bernoulli(\\mu_i)$$"
    )
  })
  
  output$modelVisual2_1 = renderUI(expr = {
    withMathJax(
      "$$y_i = malignance \\, of \\, cancer \\, case \\, i$$",
      "$$x_{1,i} = max \\, concave \\, points \\, of \\, cancer \\, case \\, i$$",
      "$$x_{2,i} = texture \\, of \\, cancer \\, case \\, i \\, (grayscale \\, deviation)$$",
      "$$x_{3,i} = max \\, radius \\, of \\, cancer \\, case \\, i$$",
      "$$logistic(x) = \\frac{1}{1 + e^{-x}}$$"
    )
  })
  
  output$modelVisual2_2 = renderUI(expr = {
    withMathJax(
      "$$\\hat{\\beta}_0 = -34.58$$",
      "$$\\hat{\\beta}_1 = 57.71$$",
      "$$\\hat{\\beta}_2 = 0.306$$",
      "$$\\hat{\\beta}_3 = 1.154$$",
      "$$\\hat{\\alpha} = 0.0001$$"
    )
  })
  
  output$logOdds = renderUI(expr = {
    withMathJax(
      sprintf(
        "$$x = \\hat{\\beta}_0 + %.2f  \\hat{\\beta}_1 + %.0f  \\hat{\\beta}_2 + %.0f  \\hat{\\beta}_3 = %.2f$$",
        input$x1, input$x2, input$x3, -34.58+57.71*input$x1+0.306*input$x2+1.154*input$x3
      ),
      sprintf(
        "$$\\hat{\\mu} = \\frac{1-\\alpha}{1+e^{-x}} + \\frac{1}{2}\\alpha = %.2f$$",
        (1-0.0001)/(1+exp(-(-34.58+57.71*input$x1+0.306*input$x2+1.154*input$x3))) + 0.5*0.0001
      ),
      sprintf(
        "$$y=%.0f$$",
        if((1-0.0001)/(1+exp(-(-34.58+57.71*input$x1+0.306*input$x2+1.154*input$x3))) + 0.5*0.0001 > 0.5) {
          1
        } else {
          0
        }
      )
    )
  })
}

shinyApp(ui, server)