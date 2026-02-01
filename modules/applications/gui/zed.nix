{ config, lib, pkgs, ... }:
let
  cfg = config.host.home.applications.zed;
in
with lib;
{
  options = {
    host.home.applications.zed = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Zed editor";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zed-editor
    ];

    programs.zed-editor = {
      enable = true;
      extensions = [ "nix" "toml" "rust" ];
      userSettings = {
        # assistant = { };
        theme = {
          mode = "system";
          dark = "One Dark";
          light = "One Light";
        };
        hour_format = "hour24";
        vim_mode = true;

        auto_update = false;
      };
    };
  };
}
