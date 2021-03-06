## Machine Learning Online Class - Exercise 2: Logistic Regression
#
#  Instructions
#  ------------
#
#  This file contains code that helps you get started on the second part
#  of the exercise which covers regularization with logistic regression.
#
#  You will need to complete the following functions in this exericse:
#
#     sigmoid.jl
#     costFunction.jl
#     predict.jl
#     costFunctionReg.jl
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
push!(LOAD_PATH, ".")

using Gadfly, NLopt, LogisticRegression

## Load Data
#  The first two columns contains the X values and the third column
#  contains the label (y).

data = readcsv("ex2data2.txt")
X = data[:, [1, 2]]
y = data[:, 3]

ls = plotData(X, y)

# Labels and Legend
p1 = plot(ls..., Guide.xlabel("Microchip Test 1"), Guide.ylabel("Microchip Test 2"), Scale.color_discrete())
draw(SVGJS("ex2-dataset-reg.js.svg", 6inch, 6inch), p1)

## =========== Part 1: Regularized Logistic Regression ============
#  In this part, you are given a dataset with data points that are not
#  linearly separable. However, you would still like to use logistic
#  regression to classify the data points.
#
#  To do so, you introduce more features to use -- in particular, you add
#  polynomial features to our data matrix (similar to polynomial
#  regression).
#

# Add Polynomial Features

# Note that mapFeature also adds a column of ones for us, so the intercept
# term is handled
X = mapFeature(X[:, 1], X[:, 2])

# Initialize fitting parameters
initial_theta = zeros(size(X, 2), 1)

# Set regularization parameter lambda to 1
lambda = 1

# Compute and display initial cost and gradient for regularized logistic
# regression
cost, grad = costFunctionReg(initial_theta, X, y, lambda)

@printf("Cost at initial theta (zeros): %f\n", cost)

@printf("\nProgram paused. Press enter to continue.\n")
readline()

## ============= Part 2: Regularization and Accuracies =============
#  Optional Exercise:
#  In this part, you will get to try different values of lambda and
#  see how regularization affects the decision coundart
#
#  Try the following values of lambda (0, 1, 10, 100).
#
#  How does the decision boundary change when you vary lambda? How does
#  the training set accuracy vary?
#

# Initialize fitting parameters
initial_theta = zeros(size(X, 2))

# Set regularization parameter lambda to 1 (you should vary this)
lambda = 1

# Set Options
options = Opt(:LN_NELDERMEAD, size(X, 2))
min_objective!(options, (theta, grad) -> costFunctionReg(theta, X, y, lambda)[1])
maxeval!(options, 1000)

# Optimize
(cost, theta, exit_flag) = optimize(options, initial_theta)

# Plot Boundary
ls = plotDecisionBoundary(theta, X, y)
p2 = plot(ls..., Guide.title(@sprintf("lambda = %d", lambda)),
       Guide.xlabel("Microchip Test 1"), Guide.ylabel("Microchip Test 2"))
draw(SVGJS("ex2-logistic-regression-reg.js.svg", 6inch, 6inch), p2)

# Compute accuracy on our training set
p = predict(theta, X)

@printf("Train Accuracy: %f\n", mean(p .== y) * 100)
