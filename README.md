# Slurm with R

The scripts in this repository illustrate how I tend to run simulations using the Slurm batch queue system on my local high performance computing cluster [www.sharcnet.ca](Sharcnet). My setup involves three main `R` scripts:

1) `slurm_example_functions.R`
  This script contains a function that wraps the simulation. I've called it `simulation_wrapper()`. The function accepts a single argument which is a vector of parameters that control the simulation. In this case, the simulation generates random variables from a uniform distribution where the number of variables (`n`), the lower bound (`lower`), and the upper bound (`upper`) vary across the scenarios. In my terminology, a scenario represents a different setting of the parameters and a replicate represents a single run of the simulation within a scenario. The function unpacks the parameters from the input vector (this is not necessary but I find it helpful to keep track) and then passes these to further functions that run a replicate of the simulation. Here I have simply used `runif()` to generate uniform random variables. Your simulation will likely run other functions you have written to simulate data, fit a model, and summarize the results. 
  
  
