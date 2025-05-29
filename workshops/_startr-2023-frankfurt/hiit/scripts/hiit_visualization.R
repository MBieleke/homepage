# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 
# EXPLORATION AND VISUALIZATION IN THE FIFA DATASET
# Author: Maik Bieleke
# 
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Load packages -----------------------------------------------------------
library(rio)
library(dplyr)
library(ggplot2)


# Import the dataset ------------------------------------------------------
hiit <- rio::import("data/hiit_long.xlsx")



# Aggregating the data ----------------------------------------------------
# As we want to plot means and standard deviations, we first compute these
# values across the three time points (pre, post1, post2) for each sex.

# First, select the RSA data with the dplyr::filter() function
rsa_data <- dplyr::filter(hiit, Measure == "RSA")

# Compute the mean and the standard for each sex and time point
rsa_aggr <- dplyr::summarise(dplyr::group_by(rsa_data, Sex, Time), 
                             MEAN = mean(Value), SD = sd(Value))

# The result is a data frame with the means and standard deviations
# that we want to plot.


# Creating the basic line plot --------------------------------------------
# Now we are ready to plot the aggregated data in rsa_aggr.
# We will proceed step by step, as in the lecture.

# Specify the data
p <- ggplot(data = rsa_aggr)
p

# Add global aesthetics
# We need position (x and y) and we want to group the plot according to sex
p <- ggplot(rsa_aggr, aes(x = Time, y = MEAN, group = Sex, color = Sex))
p

# Add a geom for the six points
p <- p + geom_point()
p

# Add a geom for three lines
p <- p + geom_line()
p

# Add a geom for error bars
# Error bars need their own y-aesthetics (min und max on the y-axis)
p <- p + geom_errorbar(aes(ymin = MEAN - SD, ymax = MEAN + SD))
p

# Here is the plot in a compact form
p <- ggplot(rsa_aggr, aes(x = Time, y = MEAN, color = Sex, group = Sex)) +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin = MEAN - SD, ymax = MEAN + SD)) 
p

# That's the basic plot! Everything else is fine-tuning.


# Fine-tuning the plot ----------------------------------------------------

# Let's start with the theme. We choose theme_bw()
ggplot(rsa_aggr, aes(x = Time, y = MEAN, color = Sex, group = Sex)) +
  theme_bw() +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin = MEAN - SD, ymax = MEAN + SD))


# The error bars are a bit too wide. We can change this with the width argument.
ggplot(rsa_aggr, aes(x = Time, y = MEAN, color = Sex, group = Sex)) +
  theme_bw() +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin = MEAN - SD, ymax = MEAN + SD), width = .1)

# Next, we change the order of the time points on the x-axis.
# To do this, we need to convert the Time variable into a factor and
# manually specify the order of the levels.
rsa_aggr <- mutate(rsa_aggr, Time = factor(Time, levels = c("Pre", "Post1", "Post2")))

# Now we can plot the data again (nothing in the code has changed)
ggplot(rsa_aggr, aes(x = Time, y = MEAN, color = Sex, group = Sex)) +
  theme_bw() +
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin = MEAN - SD, ymax = MEAN + SD), width = .1)

# That's it! Anything else you want to change? Otherwise, we can save the plot.


# Save the plot -----------------------------------------------------------
# To save the plot, we need the ggsave() function.
# It will automatically save the last plot that was created.

# We save the plot as a png file in the figures folder.
# Width and height are set to 10 cm.
ggsave("figures/hiit_rsa.png", width = 10, height = 10, units = "cm")
