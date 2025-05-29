# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 
# EXLORATION AND VIDUALIZATION IN THE FIFA DATASET
# Author: Maik Bieleke
# 
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# Packages ----------------------------------------------------------------
library(rio)   # for data import
library(skimr) # for correlation analysis
library(ggplot2)


# Import the dataset ------------------------------------------------------
fifa <- import("data/fifa.xlsx")



# Data exploration --------------------------------------------------------

# Structure of the dataset
str(fifa)

# Overview of the dataset
dplyr::glimpse(fifa)

# Number of rows
nrow(fifa)

# Number of columns
ncol(fifa)

# Dimensions (rows x columns)
dim(fifa)

# Names of the columns
names(fifa)

# First three rows
head(fifa, 3) 

# Last three rows
tail(fifa, 3)

# Summary of the variables
skimr::skim(fifa)


# Data visualization ------------------------------------------------------

# Basic plot
ggplot(data = fifa)
ggplot(data = fifa, mapping = aes(x = Overall, y = Wage))
ggplot(fifa, aes(x = Overall, y = Wage)) + geom_point()

# Scatterplot with smooth line
ggplot(fifa, aes(x = Overall, y = Wage)) +
  geom_point() + geom_smooth()

# Scatterplot with smooth line and color (global definition)
ggplot(fifa, aes(x = Overall, y = Wage, color = Foot)) +
  geom_point() +
  geom_smooth()

# Scatterplot with smooth line and color (local definition)
ggplot(fifa, aes(x = Overall, y = Wage)) +
  geom_point() +
  geom_smooth(aes(color = Foot))


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERCISE ----------------------------------------------------------------

# Produce a scatterplot for the variables "Overall" and "Potential".
# Color the points by the variable "Reputation".

# For this to work, we need to convert "Reputation" to factor first:
fifa$Reputation <- as.factor(fifa$Reputation)

# YOUR SOLUTION:

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# Common types of plots ---------------------------------------------------

# Histograms
ggplot(fifa, aes(x = Overall)) + 
  geom_histogram()
ggplot(fifa, aes(x = Overall)) + 
  geom_histogram(color = "white")

# Density plots
ggplot(fifa, aes(x = Overall)) + 
  geom_density()
ggplot(fifa, aes(x = Overall)) + 
  geom_density(aes(color = Foot))

# Boxplots
ggplot(fifa, aes(x = Overall)) + 
  geom_boxplot()
ggplot(fifa, aes(x = Overall)) + 
  geom_boxplot(aes(fill = Foot))
ggplot(fifa, aes(x = Foot, y = Overall)) + 
  geom_violin()
ggplot(fifa, aes(x = Foot, y = Overall)) + 
  geom_violin() + geom_boxplot(width = 0.1) 

# Barplots
ggplot(fifa, aes(x = Foot)) + 
  geom_bar()
ggplot(fifa, aes(x = Reputation, 
                 fill = Foot)) + 
  geom_bar(position = "stack")
ggplot(fifa, aes(x = Foot)) + 
  geom_bar(aes(fill = Foot))
ggplot(fifa, aes(x = Reputation, 
                 fill = Foot)) + 
  geom_bar(position = "dodge")


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERCISE ----------------------------------------------------------------

# Produce a boxplot that shows the distribution of "Value" by "Reputation".
# Color the points by the variable "Reputation".

# For this to work, we need to convert "Reputation" to factor first:
fifa$Reputation <- as.factor(fifa$Reputation)

# YOUR SOLUTION:

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# Fine-tuning plots -------------------------------------------------------

# Facets
ggplot(fifa, aes(x = Overall, y = Wage)) + 
  geom_point() + geom_smooth() +
  facet_wrap(~ Foot)

# Scales
ggplot(fifa, aes(x = Overall, y = Wage, color = Foot)) + 
  geom_point() + 
  scale_color_manual(values = c("blue", "red")) +
  labs(x = "Ability Score", y = "Wage in KEuro", 
       title = "Relationship between Ability and Wage",
       color = "Preferred Foot")

# Theme elements
ggplot(fifa, aes(x = Overall, y = Wage, color = Foot)) + 
  geom_point() + 
  theme(legend.position = "bottom")

# Themes
ggplot(fifa, aes(x = Overall, y = Wage, color = Foot)) + 
  geom_point() + 
  theme_bw()


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERCISE ----------------------------------------------------------------

# Produce a scatterplot for the variables "Overall" and "Potential".
# Make separate facets for each level of "Reputation".

# For this to work, we need to convert "Reputation" to factor first:
fifa$Reputation <- as.factor(fifa$Reputation)

# YOUR SOLUTION:

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
