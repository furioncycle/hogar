{ config, lib, pkgs, specialArgs, ...}:
let
  inherit (specialArgs) username;
in
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
