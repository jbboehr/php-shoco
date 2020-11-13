
# php-shoco

[![GitHub Linux Build Status](https://github.com/jbboehr/php-shoco/workflows/linux/badge.svg)](https://github.com/jbboehr/php-shoco/actions?query=workflow%3Alinux)
[![GitHub OSX Build Status](https://github.com/jbboehr/php-shoco/workflows/osx/badge.svg)](https://github.com/jbboehr/php-shoco/actions?query=workflow%3Aosx)
[![GitHub Docker Build Status](https://github.com/jbboehr/php-shoco/workflows/docker/badge.svg)](https://github.com/jbboehr/php-shoco/actions?query=workflow%3Adocker)
[![Coverage Status](https://coveralls.io/repos/jbboehr/php-shoco/badge.svg?branch=master&service=github)](https://coveralls.io/github/jbboehr/php-shoco?branch=master)
[![License](https://img.shields.io/badge/license-BSD-brightgreen.svg)](LICENSE.md)

PHP bindings for [shoco](https://github.com/Ed-von-Schleck/shoco).


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
