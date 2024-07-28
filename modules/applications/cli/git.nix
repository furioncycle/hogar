{config, lib, pkgs, ...}:

let
  cfg = config.host.home.applications.git;
in
  with lib;
{
  options = {
    host.home.applications.git = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Revision Control Tool";
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      gh = {
        enable = true;
        settings = {
          editor = "hx";
        };
      };
      git = {
        enable = true;
        lfs.enable = true;
        delta.enable = true;
        userName = "furioncycle";
        ignores = [ "*~" ".direnv" ".env" ".rgignore" ".envrc" ];
        extraConfig = {
          init = { defaultBranch = "main"; };
          pull = { ff = "only"; };
        };
      };

      bash = {
        shellAliases = {
          ga = "git add . " ;                                 # Git Add
          gp = "git push" ;                                   # Git Push
          gc = "git commit -m \"$@\"" ;                         # Git Commit
        };
      };
      # Git compatible DVCS to try out jj with git
      jujutsu = {
        enable = true;
      };
    };
  };
}
