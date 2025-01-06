![Static Analysis](https://github.com/nasa/osal/workflows/Static%20Analysis/badge.svg)
![Format Check](https://github.com/nasa/osal/workflows/Format%20Check/badge.svg)

# Core Flight System : Framework : Operating System Abstraction Layer

This repository contains NASA's Operating System Abstraction Layer (OSAL), which is a framework component of the Core Flight System.

This is a collection of abstraction APIs and associated framework to be located in the `osal` subdirectory of a cFS Mission Tree. The Core Flight System is bundled at <https://github.com/nasa/cFS>, which includes build and execution instructions.

The autogenerated OSAL user's guide can be viewed at <https://github.com/nasa/cFS/blob/gh-pages/OSAL_Users_Guide.pdf>.

# Quick Start:

Typically OSAL is built and tested as part of cFS as detailed in: [cFS repo](https://github.com/nasa/cFS)

OSAL library build pc-linux example (from the base osal directory):
```
mkdir build_osal
cd build_osal
cmake -DOSAL_SYSTEM_BSPTYPE=generic-linux ..
make
```

OSAL permissive build with tests example (see also [CI](https://github.com/nasa/osal/blob/master/.travis.yml))
```
mkdir build_osal_test
cd build_osal_test
cmake -DENABLE_UNIT_TESTS=true -DOSAL_SYSTEM_BSPTYPE=generic-linux -DOSAL_CONFIG_DEBUG_PERMISSIVE_MODE=TRUE ..
make
make test
```

See the [Configuration Guide](https://github.com/nasa/osal/blob/main/docs/OSAL-Configuration-Guide.md) for more information.

See also the autogenerated user's guide: <https://github.com/nasa/cFS/blob/gh-pages/OSAL_Users_Guide.pdf>

## Known issues

See all open issues and closed to milestones later than this version.

## Getting Help

For best results, submit issues:questions or issues:help wanted requests at <https://github.com/nasa/cFS>.

Official cFS page: <http://cfs.gsfc.nasa.gov>