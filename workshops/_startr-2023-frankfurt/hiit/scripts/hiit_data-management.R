# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 
# DATA MANAGEMENT IN THE HIIT DATASET
# Author: Maik Bieleke
# 
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# Packages ----------------------------------------------------------------
library(rio)   # for data import
library(dplyr) # for merging and aggregation
library(tidyr) # for reshaping


# Import the datasets -----------------------------------------------------

# You should have four individual files that we want to import.
hiit_m_m <- rio::import("data/hiit_f_tst.xlsx") # test data females
hiit_m_s <- rio::import("data/hiit_m_tst.xlsx") # test data males
hiit_f_m <- rio::import("data/hiit_f_rpe.xlsx") # rpe data females
hiit_f_s <- rio::import("data/hiit_m_rpe.xlsx") # rpe data males


# Merging -----------------------------------------------------------------

# We can always merge two datasets at a time using `dplyr::full_join()`.
hiit_m <- dplyr::full_join(hiit_m_m, hiit_m_s)
hiit_f <- dplyr::full_join(hiit_f_m, hiit_f_s)
hiit <- dplyr::full_join(hiit_m, hiit_f)


# Reshaping ---------------------------------------------------------------

# Wide-to-long
hiit_long <- tidyr::pivot_longer(hiit, -c(Sex, ID), 
                                 names_to = "Measurement", values_to = "Value")

# Wide-to-long with hidden identifiers
hiit_long <- tidyr::pivot_longer(hiit, -c(Sex, ID), 
                                 names_to = c("Measurement", "Time"), 
                                 names_sep = "_",
                                 values_to = "Value")

# Long-to-wide
hiit_wide <- tidyr::pivot_wider(hiit_long, 
                                names_from = c(Measurement, Time), 
                                values_from = Value)


# Aggregation -------------------------------------------------------------

# Select RSA measures for demonstration purposes
hiit_rsa <- dplyr::filter(hiit_long, Measurement == "RSA")

# Compute mean
dplyr::summarise(hiit_rsa, MEAN = mean(Value))

# Compute mean and standard deviation
dplyr::summarise(hiit_rsa, MEAN = mean(Value), SD = sd(Value))

# Group by sex
dplyr::summarise(dplyr::group_by(hiit_rsa, Sex), 
                 MEAN = mean(Value), SD = sd(Value))

# Group by sex and time
dplyr::summarise(dplyr::group_by(hiit_rsa, Sex, Time), 
                 MEAN = mean(Value), SD = sd(Value))

