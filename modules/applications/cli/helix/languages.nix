{ pkgs, lib }:
{
  

  languages  = {
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
        command = lib.exe pkgs.bash-language-server;
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
          command = lib.get pkgs.shfmt;
          args = ["-i" "2"];
        };
        auto-format = true;
      }
    ];  
  };
  
}
