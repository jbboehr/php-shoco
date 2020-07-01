let
    generateTestsForPlatform = { pkgs, path, system, phpAttr }:
        pkgs.recurseIntoAttrs {
            gcc = let
                php = pkgs.${phpAttr};
            in
            pkgs.callPackage ../default.nix {
                inherit php;
                buildPecl = pkgs.callPackage "${path}/pkgs/build-support/build-pecl.nix" { inherit php; };
            };

            clang = let
                php = pkgs.${phpAttr};
                stdenv = pkgs.clangStdenv;
            in
            pkgs.callPackage ../default.nix {
                inherit php stdenv;
                buildPecl = pkgs.callPackage "${path}/pkgs/build-support/build-pecl.nix" { inherit php stdenv; };
            };

            gcc-i686 = let
                php = pkgs.pkgsi686Linux.${phpAttr};
            in pkgs.pkgsi686Linux.callPackage ../default.nix {
                inherit php;
                pkgs = pkgs.pkgsi686Linux;
                buildPecl = pkgs.pkgsi686Linux.callPackage "${path}/pkgs/build-support/build-pecl.nix" { inherit php; };
            };
        };
in
builtins.mapAttrs (k: _v:
  let
    path = builtins.fetchTarball {
        url = https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz;
        name = "nixpkgs-20.03";
    };
    system = k;
    pkgs = import (path) { inherit system; };
  in
  pkgs.recurseIntoAttrs {
    php72 = generateTestsForPlatform {
        inherit pkgs path system;
        phpAttr = "php72";
    };

    php73 = generateTestsForPlatform {
        inherit pkgs path system;
        phpAttr = "php73";
    };

    php74 = generateTestsForPlatform {
        inherit pkgs path system;
        phpAttr = "php74";
    };
  }
) {
  x86_64-linux = {};
  # Uncomment to test build on macOS too
  # x86_64-darwin = {};
}