#!/bin/bash
#SBATCH --job-name=test-nwp ###Job Name
#SBATCH --nodes=1 # Number of nodes (min-max)
#SBATCH --partition=kamiak ###Partition on which to run
#SBATCH --time=0-02:30:00 ###days-hours:minutes:seconds
#SBATCH -o out.log
#SBATCH -e err.log

date

nwpesse input > job-nwps.log

date

