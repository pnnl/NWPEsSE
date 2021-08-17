#!/usr/bin/env python

# For using NWPEsSe with LAMMPS

import sys
import os

input_fn1 = sys.argv[1]        # dump.X.xyz
input_fn2 = sys.argv[2]        # out.X
output_fn = sys.argv[3]        # $out$
num_atps = int(sys.argv[4])    # number of atomic types
elements = []
for i in range(num_atps):
	elements.append(str(sys.argv[5+i]))

coords = []
with open(input_fn1, 'r') as fd:
    lines = fd.readlines()
    for line in lines[2:]:
        line = line.split()
        coords.append([int(line[0]), float(line[1]), float(line[2]), float(line[3])])

energy = 0.
with open(input_fn2, 'r') as fd:
    lines = fd.readlines()
    for line in lines:
        line = line.split()
        if len(line) == 3:
            if line[0] == 'FINAL' and line[1] == 'ENERGY:':
                energy = float(line[2])

with open(output_fn, 'w') as fd:    
    fd.write('%d\n' % (len(coords)))
    fd.write('%15.8f\n' % (energy))
    for coord in coords:
        fd.write('%5s %15.8f %15.8f %15.8f\n' % (elements[coord[0]-1], coord[1], coord[2], coord[3]))