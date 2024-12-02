{ lib, ... }:

with lib;
{
  imports = [
    ./android-tools.nix
    ./bat.nix
    ./bash.nix
    ./btop.nix
    ./development.nix
    ./direnv.nix
    ./duf.nix
    ./dust.nix
    ./encfs.nix
    ./file-compression.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gnupg.nix
    ./helix
    ./htop.nix
    ./jq.nix
    ./less.nix
    ./liquidprompt.nix
    ./lsd.nix
    ./mp3gain.nix
    ./mtr.nix
    ./ncdu.nix
    ./neofetch.nix
    ./nix-developmenttools.nix
    ./nmap.nix
    ./ranger.nix
    ./ripgrep.nix
    ./shfmt.nix
    ./shellcheck.nix
    ./spotify.nix
    ./timewarrior.nix
    ./wget.nix
    ./xdg-ninja.nix
    ./zathura.nix
    ./zenity.nix
    ./zoxide.nix
  ];
}
