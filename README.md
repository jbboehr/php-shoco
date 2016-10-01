
# php-shoco

[![Build Status](https://travis-ci.org/jbboehr/php-shoco.svg?branch=master)](https://travis-ci.org/jbboehr/php-shoco)
[![Coverage Status](https://coveralls.io/repos/jbboehr/php-shoco/badge.svg?branch=master&service=github)](https://coveralls.io/github/jbboehr/php-shoco?branch=master)
[![License](https://img.shields.io/badge/license-BSD-brightgreen.svg)](LICENSE.md)

PHP bindings for [shoco](https://github.com/Ed-von-Schleck/shoco).
shoco needs to be built using autoconf from [this branch](https://github.com/jbboehr/shoco/tree/autoconf).


## Installation

```sh
phpize
./configure
make
make test
sudo make install
```


## Usage

```php
$input = 'foo';
$compressed = shoco_compress($input);
$uncompressed = shoco_uncompress($compressed);
```


## License

This project is licensed under the [Simplified BSD License](LICENSE.md).
