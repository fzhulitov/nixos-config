
{
  description = "Try of flake with Home manager";

  inputs = {

   nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
#   nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
   home-manager.url = "gitlab:rycee/home-manager/release-23.05";
   nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };
  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs: {
    nixosConfigurations.a17nix = nixpkgs.lib.nixosSystem {
      modules = [ 
           nixos-hardware.nixosModules.common-hidpi
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.fedor = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          } 
      ];
      specialArgs.inputs = inputs;
      system = "x86_64-linux";
    };
  };
  nixConfig = {
#   accept-flake-config = true;
#   package = pkgs.nixFlakes;
   extraOptions = ''
     experimental-features = nix-command flakes
   '';
  };
}
