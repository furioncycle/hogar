{ config, lib, pkgs, ... }:
let
  displayServer = config.host.home.feature.gui.displayServer;
  windowManager = config.host.home.feature.gui.windowManager;
in
with lib;
{
  config = mkIf (config.host.home.feature.gui.enable && displayServer == "x" && windowManager == "cinnamon") {
    home = {
      packages = with pkgs;
        [
          bulky
          cinnamon-common
          cinnamon-control-center
          cinnamon-desktop
          cinnamon-gsettings-overrides
          cinnamon-menus
          cinnamon-screensaver
          cinnamon-session
          cinnamon-settings-daemon
          cinnamon-translations
          cjs
          mint-artwork
          mint-cursor-themes
          mint-themes
          mint-x-icons
          mint-y-icons
          muffin
          nemo-with-extensions
          pix
          warpinator
          xapp
          xreader
          xviewer
          glib
          gsettings-desktop-schemas
          killall
          libgnomekbd
          networkmanagerapplet
          polkit_gnome
          sound-theme-freedesktop
          xdg-user-dirs
        ];
    };

    xsession = {
      enable = true;
      scriptPath = ".hm-xsession";
      windowManager.command = ''
        cinnamon-session
      '';
    };
  };
}
