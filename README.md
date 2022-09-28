# Slurm with R

The scripts in this repository illustrate how I tend to run simulations using the Slurm batch queue system on my local high performance computing cluster [www.sharcnet.ca](Sharcnet). My setup involves three main `R` scripts:

1) `slurm_example_functions.R`
  The first script contains a function that wraps the simulation. I've called it `simulation_wrapper()`. The function accepts a single argument which is a vector of parameters that control the simulation. In this case, the simulation generates random variables from a uniform distribution where the number of variables (`n`), the lower bound (`lower`), and the upper bound (`upper`) vary across the scenarios. In my terminology, a scenario represents a different setting of the parameters and a replicate represents a single run of the simulation within a scenario. The function unpacks the parameters from the input vector (this is not necessary but I find it helpful to keep track) and then passes these to further functions that run a replicate of the simulation. Here I have simply used `runif()` to generate uniform random variables. Your simulation will likely run other functions you have written to simulate data, fit a model, and summarize the results. 
  
2) `generate_parameter_matrix.R`
  The second script contains code to generate the matrix of possible parameter settings. Essentially, it generates a tibble (a tidy data frame) containing the parameter values for each combination of the scenario and the replicate. The parameters are the same within each scenario and so the lines will be repeated many times with just a change to the replicate number (Rep). It would be possible to include the number of replicates for each scenario instead of copying the lines, but this works for me. Here I have defined parameters for 5 different scenarios with values of `n` between 10 and 50, `lower` between 1 and 5, and `upper` between 10 and 250. I have specified 10 replicates for each scenario, so the parameter matrix contains 50 rows. This is written to the file `parameter_matrix.csv`.
  
  
