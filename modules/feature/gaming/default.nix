{config, lib, inputs, pkgs, ...}:
let
   cfg = config.host.home.feature.gaming;
   cfg-osu = config.host.home.feature.gaming.osu;
in
  with lib;
{
  options = {
    host.home.feature.gaming = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable gaming on system";
      };
      osu = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enable OSU Rythm  game";
        };
      };
    };
  };
  
  config = mkIf (cfg.enable && cfg-osu.enable) {
    home.packages = [
      inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    ];
  };
}
