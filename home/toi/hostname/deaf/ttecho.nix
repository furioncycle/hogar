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
        zed.enable = true;
        edge.enable = false;
        visual-studio-code = {
          enable = true;
          defaultApplication.enable = true;
        };
      };
      feature = {
        gui = {
          enable = false;
          displayServer = "wayland";
          # windowManager = "";
          # windowManager = "cinnamon"; # cinnamon
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
