let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { overlays = [ (import ./nix/overlays.nix) ]; };
in
  pkgs.mkShell {
    buildInputs = [
      pkgs.kubernetes-helm
      pkgs.kube3d
      pkgs.jsonnet
      pkgs.jsonnet-bundler
      pkgs.tanka
    ];
  }
