# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 
# STATISTICAL ANALYSIS IN THE FIFA DATASET
# Author: Maik Bieleke
# 
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# Packages ----------------------------------------------------------------
library(rio)         # for data import
library(correlation) # for correlation analysis
library(parameters)  # for regression parameters
library(performance) # for regression performance
library(dplyr)       # for data processing



# Import the dataset ------------------------------------------------------
fifa <- import("data/fifa.xlsx")


# Correlation -------------------------------------------------------------

# Computing single correlations
correlation::cor_test(fifa, "Overall", "Value")

# Plotting single correlations
r <- correlation::cor_test(fifa, "Overall", "Value")
plot(r)

# Computing multiple correlations
variables <- dplyr::select(fifa, Overall, Potential, Value, Wage)
correlation::correlation(variables)

# Correlation matrix
r <- correlation::correlation(variables)
summary(r)

# Plotting multiple correlations
r <- correlation::correlation(variables)
rmat <- summary(r)
plot(rmat)


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERCISE ----------------------------------------------------------------

# Play around with the correlation analyis, using different variables.
# YOUR SOLUTION:

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



# Regression --------------------------------------------------------------

# Simple regression
model <- lm(Wage ~ Overall, data = fifa)
summary(model)

# Model parameters
parameters::parameters(model)

# Model performance
performance::performance(model)

# Model assumptions
performance::check_model(model)


# Multiple regression
model2 <- lm(Wage ~ Overall + Value, data = fifa)
summary(model2)

# Comparing models
performance::compare_performance(model, model2, metrics = "common")

# -------------------------------------------------------------------------


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERCISE ----------------------------------------------------------------

# Compute a regression that predicts reputation.
# YOUR SOLUTION:

# 1. Regress reputation on Overall, Potential, Value, and Wage with lm().

# 2. Examine the models with the parameters() function.

# 3. Check the model performance with performance().

# 4. Check the model assumptions with check_model().

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++