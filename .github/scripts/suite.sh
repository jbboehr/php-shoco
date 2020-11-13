#!/usr/bin/env bash

export COVERAGE=${COVERAGE:-true}

export PHP_WITH_EXT="`which php` -d extension=`pwd`/modules/shoco.so"

export NO_INTERACTION=1
export REPORT_EXIT_STATUS=1
export TEST_PHP_EXECUTABLE=`which php`

function before_install() (
    set -e -o pipefail

    return 0
)

function install() (
    set -e -o pipefail

    phpize
    if [[ "${COVERAGE}" = "true" ]]; then
        ./configure CFLAGS="-fprofile-arcs -ftest-coverage ${CFLAGS}" LDFLAGS="--coverage ${LDFLAGS}"
    else
        ./configure
    fi
    make clean all
)

function before_script() (
    set -e -o pipefail

    if [[ "${COVERAGE}" = "true" ]]; then
        echo "Initializing coverage"
        lcov --directory . --zerocounters
        lcov --directory . --capture --compat-libtool --initial --output-file coverage.info
    fi
)

function script() (
    set -e -o pipefail

    echo "Running main test suite"
    php run-tests.php -d extension=shoco.so -d extension_dir=modules -n ./tests/*.phpt
)

function after_success() (
    set -e -o pipefail

    if [[ "${COVERAGE}" = "true" ]]; then
        echo "Processing coverage"
        lcov --no-checksum --directory . --capture --compat-libtool --output-file coverage.info
        lcov --remove coverage.info "/usr*" \
            --remove coverage.info "*/.phpenv/*" \
            --remove coverage.info "/home/travis/build/include/*" \
            --compat-libtool \
            --output-file coverage.info
    fi
)

function after_failure() (
    set -e -o pipefail

    for i in `find tests -name "*.out" 2>/dev/null`; do
        echo "-- START ${i}";
        cat ${i};
        echo "-- END";
        done
    for i in `find tests -name "*.mem" 2>/dev/null`; do
        echo "-- START ${i}";
        cat ${i};
        echo "-- END";
    done
)

function run_all() (
    set -e
    trap after_failure ERR
    before_install
    install
    before_script
    script
    after_success
)
