{config, pkgs, lib, ...}:
let
  cfg = config.host.home.applications.edge;
in
  with lib;
{
  options = {
    host.home.applications.edge = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Microsoft edge browser"; 
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      microsoft-edge
    ];
  };
}
