
# php-shoco

[![ci](https://github.com/jbboehr/php-shoco/actions/workflows/ci.yml/badge.svg)](https://github.com/jbboehr/php-shoco/actions/workflows/ci.yml)
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

This project is licensed under the [AGPLv3.0 or later](LICENSE.md).
