# NWPEsSE

Current version: 1.1

Northwest Potential Energy Surface Search Engine (NWPEsSe) is a flexible and efficient software to search global minimum of potential energy surface in computational chemistry problems.

NWPesSe uses the very exceptionscient global optimization algorithm, based on the \the
articial bee colony algorithm" developed by Karaboga in 2005 (Karaboga, D. and Akay, B.,
2009. A comparative study of artificial bee colony algorithm. Applied mathematics and
computation, 214(1), pp.108-132), to perform the search. The algorithm has been modied
and improved specically for chemical problems. NWPesSe supports a large number of
force fields by itself, and also provide interfaces for any other third-party computational
chemistry programs, meaning that NWPesSe is able to generate reasonable initial
structures of complex topology quickly by itself and also can generate optimized cluster structures using highly accurate ab initio quantum chemistry methods!

# Install and use
We have generated a precompiled executable so there is no need to install the code. The current version of NWPesSe does not have a graphic user interface (GUI) but it is underdevelopment to be released soon.

A GCC compiler of version 5.2.0 or higher is needed to run NWPEsSE. 

See user manual in detail for using NWPEsSE.

# Citation
[1] Zhang, J.; Glezakou, V.-A.; Rousseau, R.; Nguyen, M.-T.; NWPEsSe: An Adaptive-Learning    Global Optimization Algorithm for Nanosized Cluster Systems. J. Chem. Theory Comput. 2020, 16, 3947-3958

For questions on the theory and implementation of NWPEsSe, please contact:
    Vanda Glezakou, vanda.glezakou@pnnl.gov
    Difan Zhang, difan.zhang@pnnl.gov

Other references:
[1] Zhang, J.; Dolg, M.; ABCluster: The Artificial Bee Colony Algorithm for
    Cluster Global Optimization. Phys. Chem. Chem. Phys. 2015, 17, 24173-24181.
[2] Zhang, J.; Dolg, M.; Global Optimization of Clusters of Rigid Molecules by the
    Artificial Bee Colony Algorithm. Phys. Chem. Chem. Phys. 2016, 18, 3003-3010.

