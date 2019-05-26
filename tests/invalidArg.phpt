--TEST--
shoco (invalid arg)
--SKIPIF--
<?php if(!extension_loaded('shoco')) die('skip '); ?>
--FILE--
<?php
function shocotest($val) {
    try {
        shoco_compress($val);
        echo "fail\n";
    } catch( Error $e ) {
        echo "ok\n";
    }
    try {
        shoco_decompress($val);
        echo "fail\n";
    } catch( Error $e ) {
        echo "ok\n";
    }
}

shocotest(null);
shocotest(array());
--EXPECT--
ok
ok
ok
ok