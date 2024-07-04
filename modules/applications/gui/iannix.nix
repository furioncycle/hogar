{config, lib, pkgs, ... }:
let
   cfg = config.host.home.applications.iannix;
in
  with lib;
{
  options = {
    host.home.applications.iannix = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "A graphical sequencer for digital art";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.iannix      
    ];
  };
}
