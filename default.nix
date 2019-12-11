{
  pkgs ? import <nixpkgs> {},
  php ? pkgs.php,
  buildPecl ? pkgs.callPackage <nixpkgs/pkgs/build-support/build-pecl.nix> {
    inherit php;
  },

  phpShocoVersion ? null,
  phpShocoSrc ? ./.,
  phpShocoSha256 ? null,
  phpShocoValgrind ? false
}:

pkgs.callPackage ./derivation.nix {
  inherit php buildPecl phpShocoVersion phpShocoSrc phpShocoSha256 phpShocoValgrind;
}

