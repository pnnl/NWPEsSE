#!/bin/bash

#
# Author: Kai Wang
#
# Usage: in *.inp,
#
#      >>>>
#      dmol34nwpesse.sh $xxx$ $inp$ $out$
#      >>>>
#
# Change files for your own requirement.

xyzfn=$2
outfn=$3

dmolinpfn=$1.input
dmolcarfn=$1.car
dmoloutfn=$1.outmol

# Preparing the inp file.
echo """
# Task parameters
Calculate                     optimize
Opt_energy_convergence        1.0000e-004
Opt_gradient_convergence      2.0000e-002 A
Opt_displacement_convergence  5.0000e-002 A
Opt_iterations                100
Opt_max_displacement          0.3000 A
Initial_hessian               improved
Symmetry                      off
Max_memory                    10240
File_usage                    smart
Scf_density_convergence       1.000000e-004
Scf_charge_mixing             1.800000e-001
Scf_spin_mixing               4.000000e-001
Scf_diis                      6 pulay
Scf_iterations                100

# Electronic parameters
Spin_polarization             unrestricted
Charge                        -1
Basis                         dnd
Pseudopotential               none
Functional                    pbe
Aux_density                   octupole
Integration_grid              coarse
Occupation                    thermal 0.0060
Cutoff_Global                 3.7000 angstrom

# Print options
Print                         eigval_last_it

# Calculated properties
""" > ${dmolinpfn}

# Preparing the car file.
echo """!BIOSYM archive 3
PBC=OFF
Materials Studio Generated CAR File
!DATE     `date`""" > ${dmolcarfn}
natoms=`head -n 1 ${xyzfn}`
awk 'NR>2{printf("%2s%-3d   %12.9f   %12.9f   %12.9f XXXX 1      xx      %s  0.000\n", $1, FNR-2, $2, $3, $4, $1)}' ${xyzfn} >> ${dmolcarfn}
echo """end
end""" >> ${dmolcarfn}

# Run DMol3 job.
/public/home/g09/Accelrys/MaterialsStudio8.0/etc/DMol3/bin/RunDMol3.sh -np 56 $1

# Extract results.
grep -q "Error" ${dmoloutfn} 
if [ $? -eq 0 ] ;  then
tenergy1='-0.000000'
energy1=${tenergy1:0:${#tenergy1}}
echo ${natoms} > ${outfn}
echo ${energy1} >> ${outfn}
natomsp2=`expr ${natoms} + 1`
sed '/$coordinates/,/$end/!d'  ${dmoloutfn} |head -n ${natomsp2} |tail -n ${natoms} | awk '{printf("%s %10.8f %10.8f %10.8f\n", $1, $2, $3, $4)}' >> ${outfn}

else
tenergy=`grep -A 1 "Total Energy" ${dmoloutfn} | tail -n 1 | awk '{print $3}'`
energy=${tenergy:0:${#tenergy}}
echo ${natoms} > ${outfn}
echo ${energy} >> ${outfn}
natomsp1=`expr ${natoms} + 3`
sed '/Final Coordinates/,/Entering Properties/!d' ${dmoloutfn} |head -n ${natomsp1} |tail -n ${natoms} | awk '{printf("%s %10.8f %10.8f %10.8f\n", $2, $3, $4, $5)}' >> ${outfn}

fi


