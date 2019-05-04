{
  pkgs ? import <nixpkgs> {},
  php ? pkgs.php,

  phpShocoVersion ? null,
  phpShocoSrc ? ./.,
  phpShocoSha256 ? null,
  phpShocoValgrind ? false
}:

pkgs.callPackage ./derivation.nix {
  inherit php phpShocoVersion phpShocoSrc phpShocoSha256 phpShocoValgrind;
}

