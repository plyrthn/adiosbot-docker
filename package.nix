{
  pkgs,
}:
pkgs.stdenv.mkDerivation {
  name = "adiosbot";
  pname = "adiosbot";
  propagatedBuildInputs = [
    pkgs.python3Packages.discordpy
    pkgs.python3Packages.pytz
  ];
  dontUnpack = true;
  installPhase = ''
    install -Dm755 ${./main.py} $out/bin/adiosbot
    install -Dm644 ${./goodbye_songs.json} $out/bin/goodbye_songs.json
  '';
}
