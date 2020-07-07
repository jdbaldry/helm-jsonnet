{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "jsonnet-bundler";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "jsonnet-bundler";
    repo = pname;
    rev = "v${version}";
    sha256 = "0pk6nf8r0wy7lnsnzyjd3vgq4b2kb3zl0xxn01ahpaqgmwpzajlk";
  };

  modSha256 = "03gxj0zrriz2gydak98syxgl0fl8hjzbzzl54m84md4n2g19nv0l";

  meta = with stdenv.lib; {
    description = "A jsonnet package manager.";
    license = licenses.asl20;
  };
}
