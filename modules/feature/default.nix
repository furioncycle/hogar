{lib, ...}:

with lib;
{
  imports = [
    ./emulation
    ./fonts.nix
    ./gaming
    ./mime-defaults.nix
    ./theming.nix
  ];
}
