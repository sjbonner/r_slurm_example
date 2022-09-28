#!/bin/bash
#SBATCH --array=1-10
#SBATCH --time=00:05:00
#SBATCH --mem=1G
#SBATCH --error=Logs/rep_%A_%a.log
#SBATCH --output=Logs/rep_%A_%a.log

module load StdEnv/2020  gcc/9.3.0  r/4.1.2

Rscript --vanilla slurm_example.R $SLURM_ARRAY_TASK_ID parameter_matrix.csv &> Logs/rep_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.log
