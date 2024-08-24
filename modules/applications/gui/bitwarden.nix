{ config, lib, pkgs, ...}:
let
   cfg = config.host.home.applications.bitwarden;
in
   with lib;
{
  options = {
    host.home.applications.bitwarden = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Bitwarden password manager application";
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = [
        pkgs.bitwarden-desktop
        pkgs.bitwarden-cli
      ];
    };
  };
}
