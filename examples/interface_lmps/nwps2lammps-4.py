#!/usr/bin/env python
"""
This is added to check if the $out$ is written properly. Lammps error may write a wrong $out$, which causes NWPESSE stops.
"""
import sys

input_fn1 = sys.argv[1]        # $inp$
input_fn2 = sys.argv[2]        # $out$

with open(input_fn2, 'r') as fd:
    lines = fd.readlines()
    try:
      natom2 = int(lines[0])
    except:
      natom2 = 0

with open(input_fn1, 'r') as fd:
    lines = fd.readlines()
    natom = int(lines[0])

if natom == natom2:
  pass
else:
  with open(input_fn2, 'w') as fd:    
    fd.write(lines[0])
    fd.write('0.0\n')
    for l in lines[2:]:
      fd.write(l)
