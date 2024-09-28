
PHP_ARG_ENABLE(shoco,     whether to enable shoco,
[AS_HELP_STRING([--enable-shoco], [Enable shoco])])

PHP_ARG_ENABLE(shoco-coverage, whether to enable shoco coverage support,
[AS_HELP_STRING([--enable-shoco-coverage], [Enable shoco coverage support])], [no], [no])

if test "$PHP_SHOCO" != "no"; then
    if test "$PHP_SHOCO_COVERAGE" == "yes"; then
        CFLAGS="-fprofile-arcs -ftest-coverage $CFLAGS"
        LDFLAGS="--coverage $LDFLAGS"
    fi

    AH_BOTTOM([
#ifdef __clang__
#include "main/php_config.h"
#/**/undef/**/ HAVE_ASM_GOTO
#endif
    ])
    dnl PHP_ADD_LIBRARY(shoco, 1, SHOCO_SHARED_LIBADD)
    PHP_ADD_INCLUDE(shoco)
    PHP_NEW_EXTENSION(shoco, php_shoco.c shoco/shoco.c, $ext_shared, , $PHP_SHOCO_FLAGS)
    PHP_SUBST(SHOCO_SHARED_LIBADD)
    CFLAGS="$CFLAGS -std=c99"
fi
