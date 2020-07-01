{
  php, stdenv, autoreconfHook, fetchurl, lib,
  buildPecl ? import <nixpkgs/pkgs/build-support/build-pecl.nix> {
    # re2c is required for nixpkgs master, must not be specified for <= 19.03
    inherit php stdenv autoreconfHook fetchurl;
  },
  valgrind ? null,
  phpShocoVersion ? null,
  phpShocoSrc ? null,
  phpShocoSha256 ? null,
  phpShocoValgrind ? false
}:

let
  orDefault = x: y: (if (!isNull x) then x else y);
in

buildPecl rec {
  pname = "shoco";
  name = "shoco-${version}";
  version = orDefault phpShocoVersion "v0.1.0";
  src = orDefault phpShocoSrc (fetchurl {
    url = "https://github.com/jbboehr/php-shoco/archive/${version}.tar.gz";
    sha256 = orDefault phpShocoSha256 "0zhawzpary1j91038khxnzwnijkrdpsxi8wspp72q3x328xy6g04";
  });

  makeFlags = ["phpincludedir=$(out)/include/php/ext/shoco"];

  doCheck = true;
  checkTarget = "test";
  checkInputs = lib.optional phpShocoValgrind [ valgrind ];
  checkFlags = ["REPORT_EXIT_STATUS=1" "NO_INTERACTION=1"]
    ++ (lib.optional phpShocoValgrind ["TEST_PHP_ARGS=-m"]);
}

