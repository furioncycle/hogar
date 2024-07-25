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
        zed.enable = true;
        edge.enable = true;
        visual-studio-code = {
          enable = true;
          defaultApplication.enable = true;
        };     
      };
      feature = {
        gui = {
          enable = true;
          displayServer = "x";
          windowManager = "cinnamon"; # cinnamon
        };
        gaming = {
          enable = true;
          osu.enable = true;
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
