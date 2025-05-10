{ ... }:
{
  host = {
    home = {
      applications = {
        android-tools.enable = false;
        calibre.enable = false;
        encfs.enable = false;
        git.enable = true;
        iannix.enable = true;
        libreoffice.enable = false; # Failing currently
        obsidian.enable = false;
        spotify.enable = false;
        zed.enable = false;
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
          enable = false;
          # osu.enable = true;
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
