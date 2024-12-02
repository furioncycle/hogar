{ config, lib, pkgs, ... }:
with lib;
{
  imports = [
  ];

  host = {
    home = {
      applications = {
        android-tools.enable = mkDefault false;
        calibre = {
          enable = mkDefault false;
          defaultApplication.enable = mkDefault false;
        };
        direnv.enable = mkDefault true;
        git.enable = mkDefault true;
        encfs.enable = mkDefault false;
      };
      feature = { };
      service = {
        vscode-server.enable = mkDefault false;
      };
    };
  };

  xdg = {
    mimeApps = {
      enable = mkDefault false;
    };
  };
}
