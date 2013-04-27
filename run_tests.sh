#!/usr/bin/env bash
mkdir build
cd build
cmake .. -DSNAP_BUILD_ALL=TRUE # required to force all targets (including tests) to be built
cmake ..
cmake ..
make
make
make test
exit