{
  description = "TOI Home Manager configuration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    # extra-substituters = [
    # "https://nix-community.cachix.org"
    # "https://hyprland.cachix.org"
    # "https://nix-gaming.cachix.org"
    # ];
    # extra-trusted-public-keys = [
    # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    # "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    # "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    # ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";    
    # nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    flake-utils.url = "github:numtide/flake-utils";
    helix-master = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
    nix-colors.url = "github:misterio77/nix-colors";
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
    zig-overlay.url = "github:mitchellh/zig-overlay";
    # zls-master = {
    # url = "github:zigtools/zls";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      gnsn = "ttecho";

      pkgsForSystem = system: import nixpkgs {
        overlays = [
          inputs.nur.overlay
          inputs.nix-vscode-extensions.overlays.default
          inputs.nixpkgs-wayland.overlay
          inputs.zig-overlay.overlays.default
        ] ++ [
          (final: prev: {
            helix = inputs.helix-master.packages.${system}.default;
            # zls = inputs.zls-master.packages.${system}.default;
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
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ]
      (system: rec {
        legacyPackages = pkgsForSystem system;
      }) //
    {
      homeConfigurations = {
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

        "deaf.${gnsn}" = HomeConfiguration {
          extraSpecialArgs = {
            org = "toi";
            role = "workstation";
            hostname = "deaf";
            username = gnsn;
            inherit inputs outputs;
          };
        };
      };

      inherit home-manager;
      inherit (home-manager) packages;
    };
}
