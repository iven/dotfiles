{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      darwinPkgs = nixpkgs.legacyPackages.x86_64-darwin;
      linuxPkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      homeConfigurations = {
        "darwin" = home-manager.lib.homeManagerConfiguration {
          pkgs = darwinPkgs;
          modules = [ ./nix/darwin.nix ];
          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
        "linux" = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPkgs;
          modules = [ ./nix/linux.nix ];
        };
        "wukong" = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPkgs;
          modules = [ ./nix/wukong.nix ];
        };
        "maintain" = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPkgs;
          modules = [ ./nix/maintain.nix ];
        };
      };
    };
}
