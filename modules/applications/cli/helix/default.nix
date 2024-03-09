{config, inputs, lib, pkgs, ...}:
let
  cfg = config.host.home.applications.helix;
in
  with lib;
{
  options = {
    host.home.applications.helix = {
       enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Helix text editor";
      };
    };
  };

  config = mkIf cfg.enable {
    programs = {
      helix = {
        enable = true;
        settings = {
          theme = "tokyonight_storm";
          editor = {
            line-number = "relative";
            cursorline = true;
            scrolloff = 5;
            color-modes = true;
            idle-timeout = 1;
            true-color = true;
            rainbow-brackets = true;
            bufferline = "always";
            rulers = [ 100 ];
            soft-wrap.enable = true;
            completion-replace = true;

            sticky-context = {
              enable = true;
              indicator = false;
            };

            lsp = {
              display-messages = true;
              display-inlay-hints = true;
            };
            
            whitespace.render = "all";
            whitespace.characters = {
              space = "·";
              nbsp = "⍽";
              tab = "→";
              newline = "⤶";
            };

            gutters = [ "diagnostics" "line-numbers" "spacer" "diff"];
            statusline = {
              separator = "of";
              left = [ "mode" "selections" "file-type" "register" "spinner" "diagnostics" ];
              center = [ "file-name" ];
              right = [ "file-encoding" "file-line-ending" "position-percentage" "spacer" "separator" "total-line-numbers" ];
              mode = {
                normal = "NORMAL";
                insert = "INSERT";
                select = "SELECT";
              };
            };
            indent-guides = {
              render = true;
              rainbow-option = "normal";
            };
          };

          keys.normal = {
            "X" = "extend_line_above";
            "C-q" = ":bc";
            "C-d" = ["half_page_down" "align_view_center"];
            "C-u" = ["half_page_up" "align_view_center"];
            "C-s" = ":w";
          };

          keys.normal."\\" = {
            "t" = [":vs ~/todo.md"];
          };

          keys.insert = {
            "j" = { "k" = "normal_mode"; };
          };
        };
      };
    };

    home.packages = with pkgs; [
      alejandra
      nil
      gopls
      rust-analyzer
      python311Packages.python-lsp-server
      zls
    ];
    xdg.configFile."zls.json".text = builtins.toJSON {
      "$schema" = "https://raw.githubusercontent.com/zigtools/zls/master/schema.json";
      enable_ast_check_diagnostics = true;
      enable_autofix = true;
      enable_import_embedfile_argument_completions = true;
      enable_inlay_hints = true;
      inlay_hints_hide_redundant_param_names = true;
      inlay_hints_hide_redundant_param_names_last_token = true;
      enable_semantic_tokens = true;
      enable_snippets = true;
      max_detail_length = 104857;
      operator_completions = true;
      use_comptime_interpreter = true;
      warn_style = true;
      include_at_in_builtins = true;
      zig_exe_path = "${pkgs.zigpkgs.master.outPath}/bin/zig";
    };
  };
}
