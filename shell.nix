let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { overlays = [ (import ./nix/overlays.nix) ]; };
  unstable = import sources.master { };
in
  pkgs.mkShell {
    buildInputs = [
      unstable.kubernetes-helm
      pkgs.kube3d
      pkgs.jsonnet
      pkgs.jsonnet-bundler
      pkgs.tanka
    ];
  }
