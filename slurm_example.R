## Load packages
library(tidyverse)

## Load your source code
source("./slurm_example_functions.R")

## Read command line arguments
args <- commandArgs(trailingOnly=TRUE)

## Set job number
id <- as.integer(args[1])

## Read parameter matrix
params <- read_csv("./parameter_matrix.csv")

## Run simulation with parameters from id row of parameter matrix
results <- simulation_wrapper(params[id,])

## Save that number
outfile <- paste0("Output/output_",params$Scenario[id],"_",params$Rep[id],".rds")
saveRDS(results,outfile)
