{ lib, ... }:

with lib;
{
  imports = [
    ./cinnamon
    ./i3
    ./sway
  ];
}
