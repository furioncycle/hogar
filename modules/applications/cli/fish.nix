{ config, lib, pkgs, ... }:
let
  cfg = config.host.home.applications.fish;
  hasPackage = pname: lib.any (p: p ? pname && p.pname == pname) config.home.packages;
  hasRipgrep = hasPackage "ripgrep";
  hasEza = hasPackage "eza";
  hasNeomutt = config.programs.neomutt.enable;
  # hasShellColor = config.programs.shellcolor.enable;
  hasKitty = config.programs.kitty.enable;
  # shellcolor = "${pkgs.shellcolord}/bin/shellcolor";
in
with lib;
{
  options = {
    host.home.applications.fish = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Fish Shell";
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      fish = {
        enable = true;
        plugins = [
          {
            name = "fish-ssh-agent";
            src = pkgs.fetchFromGitHub {
              owner = "danhper";
              repo = "fish-ssh-agent";
              rev = "fd70a2afdd03caf9bf609746bf6b993b9e83be57";
              sha256 = "e94Sd1GSUAxwLVVo5yR6msq0jZLOn2m+JZJ6mvwQdLs=";
            };
          }
        ];
        shellAbbrs = rec {
          jql = "jq -C | less -r";
          n = "nix";
          nd = "nix develop -c $SHELL";
          ns = "nix shell";
          nsn = "nix shell nixpkgs#";
          nb = "nix build";
          nbn = "nix build nixpkgs#";
          nf = "nix flake";

          nr = "nixos-rebuild --flake .";
          nrs = "nixos-rebuild --flake . switch";
          snr = "sudo nixos-rebuild --flake .";
          snrs = "sudo nixos-rebuild --flake .";
          hm = "home-manager --flake .";
          hms = "home-manager --flake . switch";

          ls = mkIf hasEza "eza";
          ll = mkIf hasEza "eza -l";
          la = mkIf hasEza "eza -a";
          lt = mkIf hasEza "eza --tree";
          lla = mkIf hasEza "eza -la";

          mutt = mkIf hasNeomutt "neomutt";
          m = mutt;

          cik = mkIf hasKitty "clone-in-kitty --type os-window";
          ck = cik;
        };
        shellAliases = {
          clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
        };
        functions = {
          fish_greeting = "";
        };
        interactiveShellInit =
          # Open command buffer in vim when alt+e is pressed
          ''
            bind \ee edit_command_buffer
          '' +
          # kitty integration
          ''
            set --global KITTY_INSTALLATION_DIR "${pkgs.kitty}/lib/kitty"
            set --global KITTY_SHELL_INTEGRATION enabled
            source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
            set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
          '' +
          # Use vim bindings and cursors
          ''
            fish_vi_key_bindings
            set fish_cursor_default     block      blink
            set fish_cursor_insert      line       blink
            set fish_cursor_replace_one underscore blink
            set fish_cursor_visual      block
          '' +
          # Use terminal colors
          ''
            set -U fish_color_autosuggestion      brblack
            set -U fish_color_cancel              -r
            set -U fish_color_command             brgreen
            set -U fish_color_comment             brmagenta
            set -U fish_color_cwd                 green
            set -U fish_color_cwd_root            red
            set -U fish_color_end                 brmagenta
            set -U fish_color_error               brred
            set -U fish_color_escape              brcyan
            set -U fish_color_history_current     --bold
            set -U fish_color_host                normal
            set -U fish_color_match               --background=brblue
            set -U fish_color_normal              normal
            set -U fish_color_operator            cyan
            set -U fish_color_param               brblue
            set -U fish_color_quote               yellow
            set -U fish_color_redirection         bryellow
            set -U fish_color_search_match        'bryellow' '--background=brblack'
            set -U fish_color_selection           'white' '--bold' '--background=brblack'
            set -U fish_color_status              red
            set -U fish_color_user                brgreen
            set -U fish_color_valid_path          --underline
            set -U fish_pager_color_completion    normal
            set -U fish_pager_color_description   yellow
            set -U fish_pager_color_prefix        'white' '--bold' '--underline'
            set -U fish_pager_color_progress      'brwhite' '--background=cyan'

            # paths
            set PATH "$HOME/.cargo/bin" $PATH;
            set PATH "$HOME/dev/personal/cheriot-llvm/builds/cheriot-llvm/bin" $PATH;
            set PATH "$HOME/dev/personal/cheriot-sail/c_emulator" $PATH;

          '';
      };
    };
  };
}
