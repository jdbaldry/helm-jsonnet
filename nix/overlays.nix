self: super:

let
  callPackage = self.callPackage;
in
{
  tanka = callPackage ./tanka.nix { };
  jsonnet-bundler = callPackage ./jsonnet-bundler.nix { };
}
