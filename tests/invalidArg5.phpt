--TEST--
shoco (invalid arg - PHP 5)
--SKIPIF--
<?php if( !extension_loaded('shoco') || PHP_MAJOR_VERSION > 5 ) die('skip '); ?>
--FILE--
<?php
shoco_compress(array());
shoco_decompress(array());
--EXPECTF--
Warning: shoco_compress() expects parameter 1 to be string, array given in %a

Warning: shoco_decompress() expects parameter 1 to be string, array given in %a