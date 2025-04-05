{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";

    # nixpkgs.url =
    #   "github:NixOS/nixpkgs?rev=35fc22e24879ca191403a923ea7f520593621a7d";

    flake-utils = { url = "github:numtide/flake-utils"; };
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              elmPackages.elm
              elmPackages.elm-language-server
              elmPackages.elm-format
              yarn
              nodejs_23
            ];
          };
        };
      });

}
