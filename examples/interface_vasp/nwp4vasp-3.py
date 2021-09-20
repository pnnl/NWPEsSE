#!/usr/bin/env python

# This is the script to connect ABCluster with VASP.
#

import os
import sys

# Do NOT change lines below!
energy_fn = sys.argv[1]  # the energy file name.
output_fn = sys.argv[2]  # The $out$.

# Extract energy and structures.
with open(energy_fn,'r') as fd:
    lines = [ l for l in fd.readlines() if "E0" in l]
    lines = lines[-1].split("E0")
    lines = lines[1].split()[1]
energy = float(lines)

coords = []
with open("CONTCAR", "r") as fd:
    lines = fd.readlines()
    ele = []
    for a,n in zip(lines[5].split(),lines[6].split()):
      ele += [a]*int(n)
    natom = sum([int(n) for n in lines[6].split()])
    for line in lines[8:8+natom]:
        line = line.split()
        coords.append([float(line[0]), float(line[1]), float(line[2])])

with open(output_fn, "w") as fd:
    fd.write('%d\n' % (len(coords)))
    fd.write('%15.8f\n' % (energy))
    for i,coord in enumerate(coords):
        fd.write('%5s %15.8f %15.8f %15.8f\n' % (ele[i], coord[0], coord[1], coord[2]))
