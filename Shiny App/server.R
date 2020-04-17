server = function(input, output, session) {
  # Final Model
  #####
  output$modelDiagram = renderUI(expr = {
    withMathJax(
      "$$\\beta_0 \\sim Normal(0,0.5), \\quad \\beta_j \\sim Normal(0,0.5), \\quad \\alpha \\sim Beta(1,9)$$",
      "$$\\downarrow$$",
      "$$\\mu_i = logistic(\\beta_0 + \\sum_{j=1}^3 \\beta_j x_{j,i}) (1 - \\alpha) + \\frac{1}{2} \\alpha$$",
      "$$\\downarrow$$",
      "$$y_i \\sim Bernoulli(\\mu_i)$$"
    )
  })
  
  output$modelDiagram2 = renderUI(expr = {
    withMathJax(
      "$$y_i = malignance \\, of \\, cancer \\, case \\, i$$",
      "$$x_{1,i} = max \\, concave \\, points \\, of \\, cancer \\, case \\, i$$",
      "$$x_{2,i} = max \\, texture \\, of \\, cancer \\, case \\, i$$",
      "$$x_{3,i} = max \\, radius \\, of \\, cancer \\, case \\, i$$",
      "$$logistic(x) = \\frac{1}{1 + e^{-x}}$$"
    )
  })
  
  output$modelDiagram3 = renderUI(expr = {
    withMathJax(
      "$$\\hat{\\beta}_0 = -34.58$$",
      "$$\\hat{\\beta}_1 = 57.71$$",
      "$$\\hat{\\beta}_2 = 0.306$$",
      "$$\\hat{\\beta}_3 = 1.154$$"
    )
  })
  #####
}