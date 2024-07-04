{ config, lib, pkgs, ...}:
let 
  cfg = config.host.home.applications.spotify;
in
   with lib;
{
  options = {
    host.home.applications.spotify = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Spotify for the terminal";
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      spotify-player.enable = true;
    };
  };
}
