
# vim: tabstop=4:softtabstop=4:shiftwidth=4:noexpandtab

PHP_ARG_ENABLE(shoco, whether to enable shoco support,
[  --enable-shoco     Enable shoco support])

if test "$PHP_SHOCO" != "no"; then
    dnl PHP_ADD_LIBRARY(shoco, 1, SHOCO_SHARED_LIBADD)
    PHP_ADD_INCLUDE(shoco)
    PHP_NEW_EXTENSION(shoco, php_shoco.c shoco/shoco.c, $ext_shared, , $PHP_SHOCO_FLAGS)
    PHP_SUBST(SHOCO_SHARED_LIBADD)
    CFLAGS="$CFLAGS -std=c99"
fi
