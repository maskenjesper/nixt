{
  description = "Elixir";
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
      devShells = with pkgs; {
        default = mkShell {
          buildInputs = [
            elixir
            sqlite
          ];
        };
      };
    });
}
