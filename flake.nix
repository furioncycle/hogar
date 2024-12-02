{
  description = "TOI Home Manager configuration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    helix-master = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
    zig-overlay.url = "github:mitchellh/zig-overlay";
    ziggy.url = "github:kristoff-it/ziggy";

    # zls-master = {
    # url = "github:zigtools/zls";
    # inputs.nixpkgs.follows = "nixpkgs";
    # };

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
