## Load packages
library(tidyverse)

## Generate parameter settings
params <- tibble(Scenario = 1:5,
                 n = 10 * (1:5),
                 lower = 1:5,
                 upper = 10 * (1:5)^2) %>%
  crossing(Rep = 1:10)

## Write parameter matrix to file
write_csv(params,"parameter_matrix.csv")

