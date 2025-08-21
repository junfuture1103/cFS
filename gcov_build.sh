make clean
make distclean

export CFLAGS="-fprofile-arcs -ftest-coverage"
export CXXFLAGS="-fprofile-arcs -ftest-coverage"
export LDFLAGS="-lgcov --coverage"

#export GCOV_PREFIX=/mnt/gcov_shared
#export GCOV_PREFIX_STRIP=2

make SIMULATION=native prep
make
make install
make test