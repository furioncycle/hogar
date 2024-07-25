{ lib, ...}:
  with lib;
{
  host = {
    home = {
      applications = {
        git.enable = mkDefault true;
        
      };
    };
  };

  programs = {
    git = {
      userEmail = "ttecho2021@gmail.com";
    };
  };
}
