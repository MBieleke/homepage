# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 
# STATISTICAL ANALYSIS IN THE HIIT DATASET
# Author: Maik Bieleke
# 
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# Packages ----------------------------------------------------------------
library(rio)     # for data import
library(afex)    # for ANOVA
library(emmeans) # for estimated marginal means


# Import the dataset ------------------------------------------------------
hiit <- import("data/hiit.xlsx")
hiit_long <- import("data/hiit_long.xlsx")


# t-tests -----------------------------------------------------------------

# Test whether pre-training performance is different from 0
t.test(hiit$RSA_Pre)

# Compare pre-training performance between males and females
t.test(RSA_Pre ~ Sex, data = hiit)

# Compare pre- and post-training performance within individuals
t.test(hiit$RSA_Pre, hiit$RSA_Post1, paired = TRUE)


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERCISE ----------------------------------------------------------------

# Use the t.test() function to test whether RSA differed at Post1 vs Post2
# YOUR SOLUTION:

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



# ANOVA -------------------------------------------------------------------

# Between-subject predictor: Sex
data <- dplyr::filter(hiit_long, Measure == "RSA" & Time == "Pre")
afex::aov_4(Value ~ Sex + (1 | ID), data)


# Within-subject predictor: Time
data <- dplyr::filter(hiit_long, Measure == "RSA")
afex::aov_4(Value ~ 1 + (Time | ID), data)


# Within-subject predictor: Time
data <- dplyr::filter(hiit_long, Measure == "RSA")
model <- afex::aov_4(Value ~ 1 + (Time | ID), data)

# Esimate the marginal means
emm <- emmeans::emmeans(model, ~ Time)
emm

# Conduct pairwise comparisons
pairs(emm)


# Between-subject predictor: Sex, Within-subject predictor: Time
data <- dplyr::filter(hiit_long, Measure == "RSA")
afex::aov_4(Value ~ Sex + (Time | ID), data)


# Between-subject predictor: Sex, Within-subject predictor: Time
data <- dplyr::filter(hiit_long, Measure == "RSA")
model <- afex::aov_4(Value ~ Sex + (Time | ID), data)

# Esimate the marginal means
emm <- emmeans::emmeans(model, ~ Sex * Time)

# Estimate simple effects
emmeans::joint_tests(emm, by = "Time")

# -------------------------------------------------------------------------


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERCISE ----------------------------------------------------------------

# Compute a mixed ANOVA for the CMJs.
# YOUR SOLUTION:

# 1. Filter the data for the CMJ measure with dplyr::filter()

# 2. Use the aov_4() function to compute a mixed ANOVA.

# 3. Use the emmeans() function to estimate the marginal means.

# 4. Use the joint_tests() function to estimate the simple effects of sex.

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++