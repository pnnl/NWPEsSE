#!/bin/bash

# Usage: in *.inp,
#
#      >>>>
#      nwchem4nwpesse.sh $xxx$ $inp$ $out$
#      >>>>
#
# Change the line 
#  
#      basis; * library def2-tzvp; end ... TASK scf optimize """
#
# for your own requirement.

fn=$1-nwchem
xyzfn=$2
outfn=$3
echo """start
geometry""" > ${fn}.nw
awk 'NR>2{print}' ${xyzfn} >> ${fn}.nw
echo """ end
basis; * library def2-tzvp; end
driver; xyz test; end
TASK scf optimize """ >> ${fn}.nw
nwchem.x ${fn}.nw > ${fn}.out
energy =`grep "Total SCF energy" ${fn}.out | tail -n 1 | awk '{print $5}'`
fnstring = `ls geom*`
read -a fns <<< ${fnstring}
fnopt=${fns[${#fns[*]}-1]}
sed "2s/^.*$/${energy}/" ${fnopt} > ${outfn}
rm ${fn}.*geom*

