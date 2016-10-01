#!/bin/sh

set -e

export PREFIX="$HOME/build"
export PATH="$PREFIX/bin:$PATH"
export CFLAGS="-L$PREFIX/lib"
export CPPFLAGS="-I$PREFIX/include"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
export NO_INTERACTION=1
export REPORT_EXIT_STATUS=1
export TEST_PHP_EXECUTABLE=`which php`

if [ ! -z "$2" ]; then
    ACTION="${2}_${1}"
else
    ACTION=$1
fi

set -ex

case "${ACTION}" in
before_install)
    cd shoco
    ./bootstrap
    ./configure --prefix=$PREFIX
    make install
    cd ..
    ;;
coverage_install)
    phpize
    ./configure --enable-shoco CFLAGS="--coverage -fprofile-arcs -ftest-coverage $CFLAGS" LDFLAGS="--coverage"
    make
    ;;
valgrind_install)
    phpize
    ./configure --enable-shoco
    make
    ;;
coverage_before_script)
    lcov --directory . --zerocounters
    lcov --directory . --capture --compat-libtool --initial --output-file coverage.info
    ;;
valgrind_before_script)
    ;;
coverage_script)
    $TEST_PHP_EXECUTABLE run-tests.php -d extension=shoco.so -d extension_dir=modules -n ./tests/
    ;;
valgrind_script)
    $TEST_PHP_EXECUTABLE run-tests.php -m -d extension=shoco.so -d extension_dir=modules -n ./tests/
    ;;
coverage_after_success)
    lcov --no-checksum --directory . --capture --compat-libtool --output-file coverage.info
    lcov --remove coverage.info "/usr*" --remove coverage.info "*/.phpenv/*" --remove coverage.info "/home/travis/build/include/*" --compat-libtool --output-file coverage.info
    coveralls-lcov coverage.info
    ;;
after_failure)
    for i in `find tests -name "*.out" 2>/dev/null`; do
        echo "-- START ${i}"; cat $i; echo "-- END";
    done
    for i in `find tests -name "*.mem" 2>/dev/null`; do
        echo "-- START ${i}"; cat $i; echo "-- END";
    done
    ;;
*)
    echo "Invalid action: $ACTION"
    exit 1
    ;;
esac

exit 0
