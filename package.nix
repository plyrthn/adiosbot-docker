{
  pkgs,
}:
pkgs.stdenv.mkDerivation {
  name = "autoaspm";
  pname = "autoaspm";
  propagatedBuildInputs = [
    pkgs.python3Packages.nextcord
    pkgs.python3Packages.pytz
  ];
  dontUnpack = true;
  installPhase = ''
    install -Dm755 ${./main.py} $out/bin/adiosbot
    install -Dm644 ${./goodbye_songs.json} $out/bin/goodbye_songs.json
  '';
}
