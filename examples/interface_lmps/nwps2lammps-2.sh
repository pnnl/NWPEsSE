#!/bin/bash

source /etc/profile.d/modules.sh

module load intel
lmp_mpi < input_lmps > job.log


