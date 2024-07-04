{ config, lib, pkgs, ...}:
let
   cfg = config.host.home.applications.development;
in
   with lib;
{
  options = {
    host.home.applications.development = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "pleathora of dev tools";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zigpkgs.master #zig
    ];
  };
}
