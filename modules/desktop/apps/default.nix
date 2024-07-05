{lib, ...}:

with lib;
{
  imports = [
    ./alttab.nix
    ./arandr.nix
    ./autotiling.nix
    ./betterlockscreen.nix
    ./cliphist.nix
    ./feh.nix
    ./grim.nix
    ./hyprpaper.nix
    ./i3status-rs.nix
    ./nitrogen.nix
    ./numlockx.nix
    ./nwg-displays.nix
    ./playerctl.nix
    ./picom.nix
    ./redshift.nix
    ./slurp.nix
    ./swayidle.nix
    ./swaylock.nix
    ./swaynotificationcenter.nix
    ./swayosd.nix
    ./sysstat.nix
    ./volctl.nix
    ./waybar.nix
    ./wayprompt.nix
    ./wdisplays.nix
    ./wev.nix
    ./wl-clipboard.nix
    ./wl-gammarelay-rs.nix
    ./wlr-randr.nix
    ./wlogout.nix
    ./xbanish.nix
    ./xbindkeys.nix
    ./xdotool.nix
    ./xbacklight.nix
    ./xidlehook.nix
    ./xdpyinfo.nix
    ./xev.nix
    ./xprop.nix
  ];
}
