#!/bin/bash

# Usage: in *.inp,
#
#      >>>>
#      orca4nwpesse.sh $xxx$ $inp$ $out$
#      >>>>
#
# Change the line 
#  
#      echo """ ! B3LYP ... """"
#
# for your own requirement.

# Create input file
fn=$1-orca
xyzfn=$2
outfn=$3
echo """ ! B3LYP D3BJ TZVPP TZVPP/JK RIJCOSX TightSCF OPT
* xyz 0 1""" > ${fn}.inp
awk 'NR>2{print}' ${xyzfn} >> ${fn}.inp
echo "*" >> ${fn}.inp

# Run the calculation
orca ${fn}.inp > ${fn}.out

# Transform the output file
energy=`grep "Total Energy" ${fn}.out | tail -n 1 | awk '{print $4}'`
sed "2s/^.*$/${energy}/" ${fn}.xyz > ${outfn}
rm -rf ${fn}.engrad ${fn}.gbw ${fn}.opt ${fn}.prop ${fn}.trj ${fn}.xyz

