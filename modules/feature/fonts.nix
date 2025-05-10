{ config, lib, pkgs, ... }:

let
  cfg = config.host.home.feature.fonts;
in
with lib;
{
  options = {
    host.home.feature.fonts = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Enable fonts";
      };
    };
  };

  config = mkIf cfg.enable {
    fonts = {
      fontconfig = {
        enable = true;
      };
    };

    home.packages = with pkgs; [
      atkinson-hyperlegible-next
      atkinson-hyperlegible-mono
      noto-fonts-emoji
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      fira-code-symbols
    ];
  };
}
