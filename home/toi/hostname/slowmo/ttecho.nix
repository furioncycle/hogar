{ config, lib, pkgs, ... }:
{
  host = {
    home = {
      applications = {
        act.enable = false;
        android-tools.enable = false;
        calibre.enable = true;
        docker-compose.enable = false;
        encfs.enable = false;
        git.enable = true;
        # helix.enable = true;
        neovim.enable = false;
        nextcloud-client.enable = false;
        tea.enable = false;
      };
      feature = {
        gui = {
          enable = true;
          displayServer = "wayland";
          windowManager = "sway";
        };
      };
      service = {
        # decrypt_enfs_workspace.enable = false;
        vscode-server.enable = true;
      };
    };
  };

  xdg.mimeApps.enable = false;
}
