let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { overlays = [ (import ./nix/overlays.nix) ]; };
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.kubernetes-helm
      pkgs.jsonnet
      pkgs.jsonnet-bundler
      pkgs.tanka
    ];
  }
