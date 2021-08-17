#!/bin/bash

# Usage: in *.inp,
#
#      >>>>
#      cp2k4nwpesse.sh $xxx$ $inp$ $out$
#      >>>>
#
# Change files for your own requirement.

# Prepare the variables.
sysfn=$1
xyzfn=$2
outfn=$3

# Modify the coordinate file to meet the CP2K input grammar.
natoms=`head -n 1 ${xyzfn}`
natomsp2=`echo "${natoms}+2" | bc`
sed -i "1,2s/^/\!/" ${xyzfn}

# For the file geoopt.tmp, there must be a line like "@include XYZ"
calctmpfn=geoopt.tmp
calcinpfn=${sysfn}.inp
calcoutfn=${sysfn}.out
# Now we are going to modify the following lines:
#
#    PROJECT_NAME
#    WFN_RESTART_FILE_NAME
#    @INCLUDE XXX
#
cp ${calctmpfn} ${calcinpfn}
dsysfn=${sysfn##*/}
dxyzfn=${xyzfn##*/}
sed -i "s/PROJECT_NAME/PROJECT_NAME  ${dsysfn}/" ${calcinpfn}
sed -i "s/WFN_RESTART_FILE_NAME/WFN_RESTART_FILE_NAME  ${dsysfn}.wfn/" ${calcinpfn}
sed -i "s/@INCLUDE  XXX/@INCLUDE  \"${dxyzfn}\"/" ${calcinpfn}

# Do the calculation.
srun --mpi=pmi2 -N 4 -n 96 -A separations -J lego /people/leem142/CP2K/cp2k-4.1/exe/Intel-libint-libxc3-elpa/cp2k.popt -i ${calcinpfn} -o ${calcoutfn}

# Collect results.
tac ${sysfn}-pos-1.xyz | head -n ${natomsp2} | tac > ${outfn}
energy=`grep "E =" ${outfn} | awk '{print $6}'`
sed -i "2c ${energy}" ${outfn}

# Decide if you want to delete any of them.
rm -rf ${sysfn}-pos-1.xyz ${sysfn}-1.restart* ${sysfn}-RESTART.wfn* #${sysfn}.inp ${sysfn}.out 
