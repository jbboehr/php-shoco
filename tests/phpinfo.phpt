--TEST--
shoco (phpinfo)
--SKIPIF--
<?php if( !extension_loaded('shoco') || PHP_MAJOR_VERSION < 7 ) die('skip '); ?>
--FILE--
<?php
phpinfo();
--EXPECTF--
%a
shoco

Version => %a
%a
