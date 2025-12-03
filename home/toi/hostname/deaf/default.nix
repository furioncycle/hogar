{ config, lib, pkgs, specialArgs, ... }:
let
  inherit (specialArgs) role;
in
with lib;
{
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];
}
