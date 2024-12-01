{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #inputs.home-manager.nixosModules.home-manager
    home-manager = { 
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
      nixosConfigurations.kevin = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.kevin = import ./home.nix;
      }
      ];
    };

  };
}
