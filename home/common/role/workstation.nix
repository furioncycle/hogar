{ lib, ... }:
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
        calibre.enable = mkDefault false;
        czkawka.enable = mkDefault false;
        diffuse = {
          enable = mkDefault false;
          defaultApplication.enable = mkDefault false;
        };
        drawio = {
          enable = mkDefault false;
          defaultApplication.enable = mkDefault false;
        };
        ferdium.enable = mkDefault true;
        firefox = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        flameshot.enable = mkDefault true;
        gnome-encfs-manager.enable = mkDefault false;
        gnome-system-monitor.enable = mkDefault true;
        gparted.enable = mkDefault true;
        greenclip.enable = mkDefault false;
        kitty.enable = mkDefault true;
        libreoffice.enable = mkDefault false;
        mp3gain.enable = mkDefault true;
        master-pdf-editor.enable = mkDefault true;
        nix-development_tools.enable = mkDefault true;
        nmap.enable = mkDefault true;
        opensnitch-ui.enable = mkDefault false;
        openshot = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        pinta.enable = mkDefault false;
        pulsemixer.enable = mkDefault true;
        seahorse.enable = mkDefault false;
        shellcheck.enable = mkDefault true;
        shfmt.enable = mkDefault true;
        smplayer = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        thunar.enable = mkDefault false;
        virt-manager.enable = mkDefault false;
        visual-studio-code = {
          enable = mkDefault false;
          defaultApplication.enable = mkDefault false;
        };
        xdg-ninja.enable = mkDefault true;
        zathura = {
          enable = mkDefault true;
          defaultApplication.enable = mkDefault true;
        };
        zenity.enable = mkDefault true;
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
