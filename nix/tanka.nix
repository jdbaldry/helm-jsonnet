{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "tanka";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "grafana";
    repo = pname;
    rev = "v${version}";
    sha256 = "02nm56iyxvyfyz6l150nqqy9dsn5r03hvmjqm9xxvs2bqlqfpnqy";
  };

  modSha256 = "1lxmhvflvln8h2xz759zql71mgjmmnagzrbnqhyg2vvgrdglf999";

  meta = with stdenv.lib; {
    description = "Flexible, reusable and concise configuration for Kubernetes";
    license = licenses.asl20;
  };
}
