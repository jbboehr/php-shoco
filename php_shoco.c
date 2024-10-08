/**
 * Copyright (c) anno Domini nostri Jesu Christi MMXVI-MMXXIV John Boehr & contributors
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include "main/php.h"
#include "main/php_ini.h"
#include "ext/standard/info.h"
#include "ext/spl/spl_exceptions.h"
#include "zend_API.h"
#include "zend_exceptions.h"

#include "shoco.h"

#include "php_shoco.h"

/* {{{ Argument Info */
#if (PHP_VERSION_ID >= 70000 && PHP_VERSION_ID <= 70200)
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO(shoco_args, IS_STRING, NULL, 0)
    ZEND_ARG_TYPE_INFO(0, data, IS_STRING, 0)
ZEND_END_ARG_INFO()
#else
ZEND_BEGIN_ARG_WITH_RETURN_TYPE_INFO(shoco_args, IS_STRING, 0)
    ZEND_ARG_TYPE_INFO(0, data, IS_STRING, 0)
ZEND_END_ARG_INFO()
#endif
/* }}} */

extern const char *PHP_SHOCO_MOTD =
    "Think not that I am come to send peace on earth: I came not to send peace, but a sword. Matthew 10:34";

/* {{{ proto string shoco_compress($input) */
PHP_FUNCTION(shoco_compress)
{
    zend_string *in = NULL;

    ZEND_PARSE_PARAMETERS_START(1, 1)
        Z_PARAM_STR(in)
    ZEND_PARSE_PARAMETERS_END();

    size_t buf_size = ZSTR_LEN(in) * 3;
    char *out = alloca(buf_size);
    size_t out_length = shoco_compress(ZSTR_VAL(in), ZSTR_LEN(in), out, buf_size);

    if (out_length > buf_size) {
        zend_throw_exception(spl_ce_RuntimeException, "Shoco compression failed", 0);
    } else {
        RETVAL_STRINGL(out, out_length);
    }
}
/* }}} */

/* {{{ proto string shoco_decompress($input) */
PHP_FUNCTION(shoco_decompress)
{
    zend_string *in = NULL;

    ZEND_PARSE_PARAMETERS_START(1, 1)
        Z_PARAM_STR(in)
    ZEND_PARSE_PARAMETERS_END();

    size_t buf_size = ZSTR_LEN(in) * 3;
    char *out = alloca(buf_size);
    size_t out_length = shoco_decompress(ZSTR_VAL(in), ZSTR_LEN(in), out, buf_size);

    if (out_length > buf_size) {
        zend_throw_exception(spl_ce_RuntimeException, "Shoco compression failed", 0);
    } else {
        RETVAL_STRINGL(out, out_length);
    }
}
/* }}} */

/* {{{ PHP_MINIT_FUNCTION */
static PHP_MINFO_FUNCTION(shoco)
{
    php_info_print_table_start();
    php_info_print_table_row(2, "Version", PHP_SHOCO_VERSION);
    php_info_print_table_row(2, "Released", PHP_SHOCO_RELEASE);
    php_info_print_table_row(2, "Authors", PHP_SHOCO_AUTHORS);
    php_info_print_table_end();

    php_info_print_box_start(0);
    PUTS(PHP_SHOCO_MOTD);
    php_info_print_box_end();

    DISPLAY_INI_ENTRIES();
}
/* }}} */

/* {{{ function_entry */
static zend_function_entry shoco_functions[] = {PHP_FE(shoco_compress, shoco_args) PHP_FE(shoco_decompress, shoco_args)
                                                    PHP_FE_END};
/* }}} */

/* {{{ shoco_deps */
static const zend_module_dep shoco_deps[] = {ZEND_MOD_REQUIRED("spl") ZEND_MOD_END};
/* }}} */

zend_module_entry shoco_module_entry = {
    STANDARD_MODULE_HEADER_EX,
    NULL,
    shoco_deps,        /* Deps */
    PHP_SHOCO_NAME,    /* Name */
    shoco_functions,   /* Functions */
    NULL,              /* MINIT */
    NULL,              /* MSHUTDOWN */
    NULL,              /* RINIT */
    NULL,              /* RSHUTDOWN */
    PHP_MINFO(shoco),  /* MINFO */
    PHP_SHOCO_VERSION, /* Version */
    STANDARD_MODULE_PROPERTIES
};

#ifdef COMPILE_DL_SHOCO
ZEND_GET_MODULE(shoco) // Common for all PHP extensions which are build as shared modules
#endif

/*
 * Local variables:
 * tab-width: 4
 * c-basic-offset: 4
 * End:
 * vim600: fdm=marker
 * vim: et sw=4 ts=4
 */
