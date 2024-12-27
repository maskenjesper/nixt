{
  description = "Lua";
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs-unstable,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      devShell = with pkgs;
        mkShell rec {
          packages = [
            fish
          ];
          buildInputs = [
            lua
          ];

          shellHook = "fish";
        };
    });
}
