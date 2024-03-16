{ config, lib, pkgs, ... }:
with lib;
{
  imports = [
  ];

  host = {
    home = {
      applications = {
        android-tools.enable = mkDefault false;
        ark = {
          enable = mkDefault false;
          defaultApplication.enable = mkDefault false;
        };
        bleachbit.enable = mkDefault false;
        blueman.enable = mkDefault true;
        calibre.enable = mkDefault true;
        chromium.enable = mkDefault true;
        comma.enable = mkDefault true;
        czkawka.enable = mkDefault false;
        diffuse = {
          enable = mkDefault false;
          defaultApplication.enable = mkDefault true;
        };
        drawio = {
          enable = mkDefault false;
          defaultApplication.enable = mkDefault true;
        };
        eog = {
          enable = mkDefault false;
          defaultApplication.enable = mkDefault true;
        };
        ferdium.enable = mkDefault true;
        firefox = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        flameshot.enable = mkDefault true;
        geeqie.enable = mkDefault false;
        gnome-encfs-manager.enable = mkDefault false;
        gnome-system-monitor.enable = mkDefault true;
        gparted.enable = mkDefault true;
        greenclip.enable = mkDefault false;
        hadolint.enable = mkDefault false ;
        kitty.enable = mkDefault true;
        libreoffice.enable = mkDefault false;
        mp3gain.enable = mkDefault true;
        master-pdf-editor.enable = mkDefault true;
        mate-calc.enable = mkDefault true;
        nextcloud-client.enable = mkDefault false;
        nix-development_tools.enable = mkDefault true;
        nmap.enable = mkDefault true;
        opensnitch-ui.enable = mkDefault false;
        openshot = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        pinta.enable = mkDefault false;
        pulsemixer.enable = mkDefault true;
        remmina = {
          enable = mkDefault false;
          defaultApplication.enable = mkDefault true;
        };
        seahorse.enable = mkDefault false;
        shellcheck.enable = mkDefault true;
        shfmt.enable = mkDefault true;
        smartgit.enable = mkDefault false;
        smplayer = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        thunar.enable = mkDefault false;
        thunderbird.enable = mkDefault false;
        virt-manager.enable = mkDefault true;
        visual-studio-code = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        wps-office.enable = mkDefault true;
        xdg-ninja.enable = mkDefault true;
        xmlstarlet.enable = mkDefault true;
        yq.enable = mkDefault false;
        yt-dlp.enable = mkDefault false;
        zathura = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        zenity.enable = mkDefault true;
        zoom.enable = mkDefault false;
      };
      feature = {
        fonts.enable = mkDefault true;
        mime.defaults.enable = mkDefault true;
        theming.enable = mkDefault true;
      };
      service = {
      };
    };
  };
}
