{config, lib, pkgs, ...}:
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

  # imports = [ ./languages.nix];

  config = mkIf cfg.enable {

    programs.helix = {
        enable = true;
        extraPackages = with pkgs; [
           alejandra
           nodePackages_latest.bash-language-server
           gopls
           lldb
           marksman
           nil
           python311Packages.python-lsp-server
           rust-analyzer
           typos-lsp
           zls
           # helix-gpt
        ];
        defaultEditor = true;
        ignores = [ "!.gitignore" "!.zig-cache" "zig-out" "!.envrc" "obj" "bin" "!.git" "!.github" "!.gitlab"];
        settings = {
           theme = "bogster";
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
             popup-border = "popup";
             soft-wrap.enable = true;
             completion-replace = true;
             mouse = false;
             sticky-context = {
               enable = true;
               indicator = false;
             };

             lsp = {
               display-messages = true;
               display-inlay-hints = true;
             };

             inline-diagnostics = {
              cursor-line = "hint";
              other-lines = "error";
            };
            
            # whitespace.render = "all";
            # whitespace.characters = {
              # space = "·";
              # nbsp = "⍽";
              # tab = "→";
              # newline = "⤶";
            # };

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

           keys = {
            normal = {
              "X" = "extend_line_above";
             "C-q" = ":bc";
             "C-d" = ["half_page_down" "align_view_center"];
             "C-u" = ["half_page_up" "align_view_center"];
             "C-s" = ":w";
              "\\" = {
                 "t" = [":vs ~/todo.md"];
              };
              "g" = {
                "a" = "code_action";
              };
              "+" = {
                "c" = ":run-shell-command cargo build";
                "t" = ":run-shell-command cargo test";
              };
            };
            insert = {
             "j" = { "k" = "normal_mode"; };
            };
          };
        };

      languages = {
        language-server = {
          nil = {
            command = "${pkgs.nil}/bin/nil";
          };
          rust-analyzer = {
            command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
            config.rust-analyzer = {
              cargo.loadDirsFromCheck = true;
              checkOnSave.command = "clippy";
              procMacro.enable = true;
              lens = {
                references = true;
                methodReferences = true;
              };
              completion.autoimport.enable = true;
            };
          };
          bash-language-server = {
            command = lib.getExe pkgs.nodePackages_latest.bash-language-server;
            args = ["start"];
          };
          typos = {
            command = "${pkgs.typos-lsp}/bin/typos-lsp";
          };
        };   

        language = [
          {
            name = "nix";
            auto-format = true;
            language-servers = [ "nil" "typos" ];
            formatter = {
              command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
            };
          }
          {
            name = "rust";
            auto-format = true;
            language-servers = [ "rust-analyzer" "typos" ];
          }
          {
            name = "go";
            language-servers = ["gopls" "typos" ];
            formatter = {
              command = "goimports";
            };
            auto-format = true;
          }
          {
            name = "markdown";
            language-servers = ["marksman" "typos" ];
            formatter = {
              command = "prettier";
              args = ["--stdin-filepath" "file.md"];
            };
            auto-format = true;
          }
          {
            name = "bash";
            formatter = {
              command = lib.getExe pkgs.shfmt;
              args = ["-i" "2"];
            };
            auto-format = true;
          }
        ]; 
      };
            
    };   

   xdg.configFile."zls.json".text = builtins.toJSON {
      "$schema" = "https://raw.githubusercontent.com/zigtools/zls/master/schema.json";
      enable_autofix = true;
      enable_inlay_hints = true;
      inlay_hints_hide_redundant_param_names = true;
      inlay_hints_hide_redundant_param_names_last_token = true;
      enable_snippets = true;
      enable_build_on_save = true;
      build_on_save_step = "check";
      warn_style = true;
      zig_exe_path = "${pkgs.zigpkgs.master.outPath}/bin/zig";
      zig_lib_path = "${pkgs.zigpkgs.master.outPath}/lib";
    };    
  };
}
