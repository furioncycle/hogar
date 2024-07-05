{ config, lib, pkgs, ...}:
{
  host = {
    home = {
      applications = {
        android-tools.enable = false;
        calibre.enable = false;
        encfs.enable = false;
        git.enable = true;
        iannix.enable = true;
        obsidian.enable = true;
        spotify.enable = true;
      };
      feature = {
        gui = {
          enable = true;
          displayServer = "x";
          windowManager = "cinnamon"; # cinnamon
        };
      };
      service = {
        # decrypt_enfs_workspace.enable = false;
        vscode-server.enable = false;
      };
    };
  };

  xdg.mimeApps.enable = false;
}
