{config, inputs, lib, pkgs, specialArgs, ...}:

let
  inherit (specialArgs) role username;
  cfg = config.host.home.feature.theming;
in
  with lib;
{
  imports = [
    inputs.nix-colors.homeManagerModule
  ];

  options = {
    host.home.feature.theming = {
      enable = mkOption {
        default = true;
        type = with types; bool;
        description = "Enable theming";
      };
    };
  };

  config = mkIf cfg.enable {
    colorscheme = inputs.nix-colors.colorSchemes.dracula;
    gtk = mkIf ((username == "ttecho" ) && ( role == "workstation")) {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
      theme = {
        name = "Zukitwo";
        package = pkgs.zuki-themes;
      };
    };

    home = mkIf ((username == "ttecho") && ( role == "workstation")) {
      packages = with pkgs;
        [
          lxappearance
        ];

      pointerCursor = mkIf ((username == "ttecho") && ( role == "workstation")) {
        gtk.enable = true;
        name = "Quintom_Snow";
        package = pkgs.quintom-cursor-theme;
      };
    };

    programs = mkIf ((username == "ttecho") && ( role == "workstation")) {
      bash = {
        sessionVariables = {
          GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
        };
      };
    };
  };
}
