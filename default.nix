{
  pkgs ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  php ? pkgs.php,
  buildPecl ? pkgs.callPackage <nixpkgs/pkgs/build-support/build-pecl.nix> {
    inherit php stdenv;
  },

  gitignoreSource ? (import (pkgs.fetchFromGitHub {
      owner = "hercules-ci";
      repo = "gitignore";
      rev = "00b237fb1813c48e20ee2021deb6f3f03843e9e4";
      sha256 = "sha256:186pvp1y5fid8mm8c7ycjzwzhv7i6s3hh33rbi05ggrs7r3as3yy";
  }) { inherit (pkgs) lib; }).gitignoreSource,

  phpShocoVersion ? null,
  phpShocoSha256 ? null,
  phpShocoValgrind ? false,
  phpShocoSrc ? pkgs.lib.cleanSourceWith {
    filter = (path: type: (builtins.all (x: x != baseNameOf path) [".idea" ".git" "ci.nix" "nix" "default.nix" ".github"]));
    src = gitignoreSource ./.;
  }
}:

pkgs.callPackage ./nix/derivation.nix {
  inherit php stdenv buildPecl;
  inherit phpShocoVersion phpShocoSrc phpShocoSha256 phpShocoValgrind;
}

