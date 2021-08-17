#!/bin/bash

# Usage: in *.inp,
#
#      >>>>
#      mopac4nwpesse.sh $xxx$ $inp$ $out$
#      >>>>
#
# for your own requirement.

# Create input file
fn=$1
xyzfn=$2
outfn=$3

natom=`head -n 1 ${xyzfn}`
mopacinfn=${fn}.mop
mopacoutfn=${fn}.out
echo "PM7 CHARGE=0  opt" > ${mopacinfn} # Change this according to your need.
echo "" >> ${mopacinfn}
awk 'NR>2{print}' ${xyzfn} >> ${mopacinfn}

# Run the calculation
mopac ${mopacinfn} > ${mopacoutfn}

# Transform the output file
energy=`grep "TOTAL ENERGY " *out | awk '{print $4}'`
coord=`grep "                             CARTESIAN COORDINATES" ${mopacoutfn} --after-context=$((natom+1)) | tail -n ${natom} | awk '{printf("%3s %20.9f %20.9f %20.9f\n", $2, $3, $4, $5)}'`
echo ${natom}  > ${outfn}
echo ${energy} > ${outfn}
echo ${natom}  > ${outfn}

# Post-process.
rm ${mopacinfn} ${mopacoutfn}


