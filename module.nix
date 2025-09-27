{
  config,
  lib,
  pkgs,
  adiosBot,
  ...
}:
let
  cfg = config.services.adiosBot;
in
{
  options.services.adiosBot = {
    enable = lib.mkEnableOption ("AdiosBot");

    botTokenFile = lib.mkOption {
      description = "Path to the file with the Discord bot token";
      type = lib.types.str;
    };

    workingDir = lib.mkOption {
      description = "Path to store the service files (e.g. user whitelist, message timestamps)";
      type = lib.types.str;
      default = "/persist/opt/services/adiosbot";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      adiosBot
    ];

    systemd.services.adios-bot = {
      description = "AdiosBot";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig =
        let
          python = pkgs.python313.withPackages (ps: [
            ps.nextcord
            ps.pytz
          ]);
        in
        {
          Type = "simple";
          ExecStart = "${lib.getExe python} ${adiosBot}/bin/adiosbot";
          EnvironmentFile = cfg.botTokenFile;
          Environment = "WORKING_DIR=${cfg.workingDir}";
        };
    };
  };
}
