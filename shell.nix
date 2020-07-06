let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.kubernetes-helm
      pkgs.jsonnet
    ];
  }
