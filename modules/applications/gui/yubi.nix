{ config, lib, pkgs, ...}:
let
   cfg = config.host.home.applications.yubi;
in
  with lib;
{
  options = {
    host.home.applications.yubi = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Yubi auth app";
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = [
        yubioath-flutter
      ];
    };
  };
}
