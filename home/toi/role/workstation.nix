{ config, lib, pkgs, ... }:
with lib;
{
  imports = [
  ];

  host = {
    home = {
      applications = {
        act.enable = mkDefault false;
        android-tools.enable = mkDefault false;
        calibre = {
          enable = mkDefault false;
          defaultApplication.enable = mkDefault true;
        };
        docker-compose.enable = mkDefault false;
        git.enable = mkDefault true;
        encfs.enable = mkDefault false;
        neovim.enable = mkDefault false;
        nextcloud-client.enable = mkDefault false;
        tea.enable = mkDefault false;
      };
      feature = {
      };
      service = {
        decrypt_encfs_workspace.enable = mkDefault false;
        vscode-server.enable = mkDefault true;
      };
    };
  };

  xdg = {
    mimeApps = {
      enable = mkDefault false;
    };
  };
}
