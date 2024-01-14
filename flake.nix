{
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts/";
    nix-systems.url = "github:nix-systems/default";
  };

  outputs = {flake-parts, nix-systems, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      debug = true;
      systems = import nix-systems;
      perSystem = {pkgs, self', ...}: let
        programName = "VerletMulti";
      in {
        packages.${programName} = pkgs.stdenv.mkDerivation {
          pname = programName;
          version = "0.1.0";
          src = ./.;
          nativeBuildInputs = with pkgs; [cmake sfml];
        };

        packages.default = self'.packages.${programName};
      };
    };
}