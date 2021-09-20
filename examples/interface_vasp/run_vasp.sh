#!/bin/bash
#SBATCH --job-name=test ###Job Name
#SBATCH --nodes=1 # Number of nodes (min-max)
#SBATCH --partition=kamiak ###Partition on which to run
#SBATCH --time=0-00:30:00 ###days-hours:minutes:seconds
#SBATCH -o out.log
#SBATCH -e err.log

###SBATCH --mail-type=ALL
###SBATCH --mail-user=carrington.moore@wsu.edu

date
#module load vasp/6.1.2/standard
#srun vasp_6.1.2_standard_std
module load vasp/5.4.4
srun vasp_std > job.log

date

