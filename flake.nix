{
  description = "TOI Home Manager configuration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "/home/ttecho/dev/nixpkgs";
    comma.url = "github:nix-community/comma";
    flake-utils.url = "github:numtide/flake-utils";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    helix-master = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zls-master = {
      url = "github:zigtools/zls/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      gn = "ttecho";
      gnsn = "ttecho";

      pkgsForSystem = system: import nixpkgs {
        overlays = [
          inputs.comma.overlays.default
          inputs.nur.overlay
          inputs.nix-vscode-extensions.overlays.default
          inputs.nixpkgs-wayland.overlay
          inputs.zig-overlay.overlays.default
        ] ++ [
          (final: prev: {
            zls = inputs.zls-master.packages.${system}.default;
            helix = inputs.helix-master.packages.${system}.default;
          })
        ];
        inherit system;
      };

      HomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
        modules = [
          (import ./home)
          (import ./modules)
        ];
        extraSpecialArgs = { };
        pkgs = pkgsForSystem (args.system or "x86_64-linux");
      } // { inherit (args) extraSpecialArgs; });
    in
      flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ] (system: rec {
        legacyPackages = pkgsForSystem system;
      }) //
      {
        homeConfigurations = {
    #       "beef.${gn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "toi";
    #           role = "workstation";
    #           hostname = "beef";
    #           username = gn;
    #           displays = 3;
    #           display_center = "DisplayPort-1";
    #           display_left = "DisplayPort-2";
    #           display_right = "HDMI-A-0";
    #           networkInterface = "wlp10s0";
    #           inherit inputs outputs;
    #         };
    #       };

    #       "butcher.${gn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "toi";
    #           role = "server";
    #           hostname = "butcher";
    #           username = gn;
    #           networkInterface = "enp6s18";
    #           inherit inputs outputs;
    #         };
    #       };

    #       "cog.${gn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "toi";
    #           role = "server";
    #           hostname = "cog" ;
    #           username = gn;
    #           networkInterface = "br0";
    #           inherit inputs outputs;
    #         };
    #       };

    #       "nakulaptop.${gn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "toi";
    #           role = "workstation";
    #           hostname = "nakulaptop";
    #           username = gn;
    #           displays = 2;
    #           display_center = "HDMI-A-0";
    #           display_right = "eDP";
    #           networkInterface = "wlo1";
    #           inherit inputs outputs;
    #         };
    #       };

    #       "nakulaptop.ireen" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "toi";
    #           role = "workstation";
    #           hostname = "nakulaptop";
    #           username = "ireen";
    #           displays = 1;
    #           display_center = "eDP";
    #           display_right = "HDMI-A-0";
    #           networkInterface = "wlo1";
    #           inherit inputs outputs;
    #         };
    #       };

    #       "selecta.${gn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "toi";
    #           role = "workstation";
    #           hostname = "selecta";
    #           username = gn;
    #           displays = 1;
    #           display_center = "HDMI-1";
    #           networkInterface = "wlo1";
    #           inherit inputs outputs;
    #         };
    #       };

    #       "selecta.media" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "toi";
    #           role = "workstation";
    #           hostname = "selecta";
    #           username = "media";
    #           displays = 1;
    #           display_center = "HDMI-1";
    #           networkInterface = "wlo1";
    #           inherit inputs outputs;
    #         };
    #       };

    #       "soy.${gn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "toi";
    #           role = "workstation";
    #           hostname = "soy";
    #           username = gn;
    #           displays = 1;
    #           networkInterface = "wlo1";
    #           inherit inputs outputs;
    #         };
    #       };

    #       "tentacle.${gn}" = HomeConfiguration {
    #         system = "aarch64-linux";
    #         extraSpecialArgs = {
    #           org = "toi";
    #           role = "server";
    #           hostname = "tentacle" ;
    #           username = gn;
    #           networkInterface = "enp6s18";
    #           inherit inputs outputs;
    #         };
    #       };

    #       "workspace.${gn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "toi";
    #           role = "server";
    #           hostname = "workspace" ;
    #           username = gn;
    #           networkInterface = "br0";
    #           inherit inputs outputs;
    #         };
    #       };

    #   ##
    #       "bell.${gnsn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "sd";
    #           role = "server";
    #           hostname = "bell";
    #           username = gnsn;
    #           inherit inputs outputs;
    #         };
    #       };

    #       "edge.${gnsn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "sd";
    #           role = "server";
    #           hostname = "edge";
    #           username = gnsn;
    #           inherit inputs outputs;
    #         };
    #       };

    #       "einstein.${gnsn}" = HomeConfiguration {
    #         system = "aarch64-linux";
    #         extraSpecialArgs = {
    #           org = "sd";
    #           role = "server";
    #           hostname = "einstein";
    #           username = gnsn;
    #           inherit inputs outputs;
    #         };
    #       };

    #       "sd20.${gnsn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "sd";
    #           role = "server";
    #           hostname = "sd20";
    #           username = gnsn;
    #           inherit inputs outputs;
    #         };
    #       };

    #       "sd91.${gnsn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "sd";
    #           role = "server";
    #           hostname = "sd91";
    #           username = gnsn;
    #           inherit inputs outputs;
    #         };
    #       };

    #       "sd102.${gnsn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "sd";
    #           role = "server";
    #           hostname = "sd102";
    #           username = gnsn;
    #           inherit inputs outputs;
    #         };
    #       };

    #       "sd111.${gnsn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "sd";
    #           role = "server";
    #           hostname = "sd111";
    #           username = gnsn;
    #           inherit inputs outputs;
    #         };
    #       };

    #       "tesla.${gnsn}" = HomeConfiguration {
    #         extraSpecialArgs = {
    #           org = "sd";
    #           role = "server";
    #           hostname = "tesla";
    #           username = gnsn;
    #           inherit inputs outputs;
    #         };
    #       };
          "slowmo.${gnsn}" = HomeConfiguration {
            extraSpecialArgs = {
              org = "toi";
              role = "workstation";
              hostname = "slowmo";
              username = gnsn;
              inherit inputs outputs;
            };
          };
          
          "slowmo.qiface" = HomeConfiguration {
            extraSpecialArgs = {
              org = "toi";
              role = "workstation";
              hostname = "slowmo";
              username = "qiface";
              inherit inputs outputs;
            };
          };      
        };

      inherit home-manager;
      inherit (home-manager) packages;
    };
}
