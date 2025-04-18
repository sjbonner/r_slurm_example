#!/bin/bash
#SBATCH --array=1-50
#SBATCH --time=00:05:00
#SBATCH --mem=1G
#SBATCH --error=Logs/rep_%A_%a.log
#SBATCH --output=Logs/rep_%A_%a.log

module load StdEnv/2023  gcc/13.3.0  r/4.4.0

Rscript --vanilla slurm_example.R $SLURM_ARRAY_TASK_ID &> Logs/rep_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.log
