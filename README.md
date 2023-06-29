# Slurm with R

The scripts in this repository illustrate how I tend to run simulations using the Slurm batch queue system on my local high performance computing cluster [www.sharcnet.ca](Sharcnet).

## R Scripts

My setup involves three main `R` scripts:

1) `slurm_example_functions.R`
  The first script contains a function that wraps the simulation. I've called it `simulation_wrapper()`. The function accepts a single argument which is a vector of parameters that control the simulation. In this case, the simulation generates random variables from a uniform distribution where the number of variables (`n`), the lower bound (`lower`), and the upper bound (`upper`) vary across the scenarios. In my terminology, a scenario represents a different setting of the parameters and a replicate represents a single run of the simulation within a scenario. The function unpacks the parameters from the input vector (this is not necessary but I find it helpful to keep track) and then passes these to further functions that run a replicate of the simulation. Here I have simply used `runif()` to generate uniform random variables. Your simulation will likely run other functions you have written to simulate data, fit a model, and summarize the results. 
  
2) `generate_parameter_matrix.R`
  The second script contains code to generate the matrix of possible parameter settings. Essentially, it generates a tibble (a tidy data frame) containing the parameter values for each combination of the scenario and the replicate. The parameters are the same within each scenario and so the lines will be repeated many times with just a change to the replicate number (Rep). It would be possible to include the number of replicates for each scenario instead of copying the lines, but this works for me. Here I have defined parameters for 5 different scenarios with values of `n` between 10 and 50, `lower` between 1 and 5, and `upper` between 10 and 250. I have specified 10 replicates for each scenario, so the parameter matrix contains 50 rows. This is written to the file `parameter_matrix.csv`.
  
3) `slurm_example.R`
  This is the script that runs each replicate of the simulation. The key feature is that it reads a value from the command line which identifies the row in the parameter matrix. This is the variable called `id`. It then runs the `simulation_wrapper()` function passing the `id`-th row of the parameter matrix as the argument. The rest of the script loads any necessary packages, reads the parameter matrix, and saves the output to a file that can be processed later.
  
## Shell scripts

The other file is a shell (Bash) script that tells the batch queue how to run. The script contains two main sections. The first section (starting with the keyword #SBATCH) tells the batch queue how to run. Here I have told the queue that I want it to run an array with 50 jobs (the number of tasks in my parameter matrix), and that each job will take no more than 5 minutes, requires 1~GB of RAM, and will write both errors and output to a file called `Logs/rep_%A_%a.log` where `%A` is the ID of the umbrella batch job and `%a` is the number of the task within the batch job. The value of `%A` is determined by the system and simply increments every time someone submits a job to the queue. The second corresponds to the tasks within the array and will run from 1 to 50. 

The second section (the lines that don't start with #SBATCH) specifies the commands that are run on the computer each time one of the tasks executes. This section contains just two lines. The first loads modules (software packages) that are necessary to execute the scripts. I've included the GNU compiler collection, R, and the standard environment. The second line run the task in R using the executable `Rscript`. Here the variables `${SLURM_ARRAY_JOB_ID}` and `${SLURM_ARRAY_TASK_ID}` are replaced with the umbrealla job ID and the task ID exactly as `%A` and `%a` above. The key is that the script will read `${SLURM_ARRAY_TASK_ID}` from the command line and use this to index the parameters in the parameter matrix. 

You can find lots more information on how to create the shell script in the [https://docs.alliancecan.ca/wiki/Running_jobs](Digital Alliance of Canada Wiki). 

## Running the jobs

### Eagle

If you would like to run your simulation on eagle then please send me an e-mail and I will tell you how to access the server. You will then be able to login with ssh (or putty etc) using your UWO credentials and use sftp (or WinSCP or cyberduck etc) to copy your files back and forth.

To run your simulation you would:
1) Move to the directory containing your scripts (`cd ...`).
2) Create the directories `Output` and `Logs` (`mkdir Output Logs`).
3) Submit the job to the queue (`sbatch slurm_example_eagle.sh`). 

If you want to check on the status of your job then you can use `squeue`. You can also terminate your job with `scancel`. You can find more details about using the slurm schedulre from the  DRA's webpage on [https://docs.alliancecan.ca/wiki/Running_jobs][Running Jobs]. 

### Sharcnet

To run the job you would log into on of the Digital Research Alliance of Canada systems which are listed [https://status.alliancecan.ca/](here). I tend to work with [https://docs.alliancecan.ca/wiki/Graham](Graham). If you have a [https://alliancecan.ca/en/membership/become-member](DRA Account) then you can login with ssh (or putty etc) and use sftp (or cyberduck etc) to copy your files across. 

To run your simulation you would:
1) Move to the directory containing your scripts (`cd ...`).
2) Create the directories `Output` and `Logs` (`mkdir Output Logs`).
3) Submit the job to the queue (`sbatch slurm_example_sharcnet.sh`). 

If you want to check on the status of your job then you can use `squeue`. You can also terminate your job with `scancel`. More details are provided at the DRA's webpage on [https://docs.alliancecan.ca/wiki/Running_jobs][Running Jobs]. 
