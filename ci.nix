let
    generateTestsForPlatform = { pkgs, php, buildPecl, phpShocoSrc }:
        pkgs.recurseIntoAttrs {
            shoco = pkgs.callPackage ./default.nix {
               inherit php buildPecl phpShocoSrc;
            };
        };
in
builtins.mapAttrs (k: _v:
  let
    path = builtins.fetchTarball {
       url = https://github.com/NixOS/nixpkgs/archive/release-20.03.tar.gz;
       name = "nixpkgs-20.03";
    };
    pkgs = import (path) { system = k; };

    phpShocoSrc = builtins.filterSource
        (path: type: baseNameOf path != ".idea" && baseNameOf path != ".git" && baseNameOf path != "ci.nix" && baseNameOf path != ".ci")
        ./.;
  in
  pkgs.recurseIntoAttrs {
    php72 = let
        php = pkgs.php72;
    in generateTestsForPlatform {
        inherit pkgs php phpShocoSrc;
        buildPecl = pkgs.callPackage "${path}/pkgs/build-support/build-pecl.nix" { inherit php; };
    };

    php73 = let
        php = pkgs.php73;
    in generateTestsForPlatform {
        inherit pkgs php phpShocoSrc;
        buildPecl = pkgs.callPackage "${path}/pkgs/build-support/build-pecl.nix" { inherit php; };
    };

    php74 = let
        php = pkgs.php74;
    in generateTestsForPlatform {
        inherit pkgs php phpShocoSrc;
        buildPecl = pkgs.callPackage "${path}/pkgs/build-support/build-pecl.nix" { inherit php; };
    };
  }
) {
  x86_64-linux = {};
  # Uncomment to test build on macOS too
  # x86_64-darwin = {};
}