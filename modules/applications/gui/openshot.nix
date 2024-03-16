{config , lib, pkgs, ...}:
let
  cfg = config.host.home.applications.openshot;
in
  with lib;
{
  options = {
    host.home.applications.openshot = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Film editing software";
      };
      defaultApplication = {
        enable = mkOption {
          description = "MIME default application configuration";
          type = with types; bool;
          default = false;
        };
        mimeTypes = mkOption {
          description = "MIME types to be the default application for";
          type = types.listOf types.str;
          default = [
            "application/x-extension-htm"
            "application/x-extension-html"
            "application/x-extension-shtml"
            "application/x-extension-xht"
            "application/x-extension-xhtml"
            "application/xhtml+xml"
            "text/html"
            "x-scheme-handler/about"
            "x-scheme-handler/chrome"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/unknown"
          ];
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        openshot-qt
        asciicam
      ];
    };

    xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication.enable (
      lib.genAttrs cfg.defaultApplication.mimeTypes (_: "openshot.desktop")
    );
  };
}
