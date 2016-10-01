--TEST--
shoco (basic)
--SKIPIF--
<?php if( !extension_loaded('shoco') ) die('skip '); ?>
--FILE--
<?php
function shocotest($str, $escape = null) {
    $ret = shoco_decompress(shoco_compress($str));
    echo ">", $escape ? addcslashes($ret, $escape) : $ret, "\n";
}
shocotest("");
shocotest("This is a large string that won't possibly fit into a small buffer");
shocotest("Übergrößenträger");
shocotest("t\200", "\200");
try {
    shocotest(null);
    echo "fail\n";
} catch( \Error $e ) {
    echo "except\n";
}
try {
    shocotest(array());
    echo "fail\n";
} catch( \Error $e ) {
    echo "except\n";
}
--EXPECT--
>
>This is a large string that won't possibly fit into a small buffer
>Übergrößenträger
>t\200
except
except
