#!/bin/bash
#SBATCH -J nwps
#SBATCH -A emslc51753
#SBATCH -t 3:59:39
#SBATCH -N 1
###SBATCH --ntasks-per-node=16
#SBATCH -o out.log
#SBATCH -e err.log

date

#module load nwchem/7.0.0

## This setting is VERY IMPORTANT. DO NOT REMOVE
##export ARMCI_DEFAULT_SHMMAX=8192

#mpirun -np 16  /home/scicons/cascade/apps/nwchem-7.0.0/bin/LINUX64/nwchem input.nw  &> job.nw
source /etc/profile.d/modules.sh

#module load nwchem/7.0.0
#/home/scicons/cascade/apps/nwchem-7.0.0/bin/LINUX64/nwchem 
#module load intel

#rm mol-LM/ -rf
module load  gcc/9.1.0
nwpesse input > job-nwps.log

date
