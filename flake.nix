
{
  description = "Try of flake with Home manager";

  inputs = {

   nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
#   nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
   home-manager.url = "gitlab:rycee/home-manager/release-23.05";
   nixos-hardware.url = "github:fzhulitov/nixos-hardware/tuf17-FA707xv";

  };
  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs: {
    nixosConfigurations.a17nix = nixpkgs.lib.nixosSystem {
      modules = [ 
#           nixos-hardware.nixosModules.asus-rog-strix-g513im
           nixos-hardware.nixosModules.asus-tuf-17fa707xv
            nixos-hardware.nixosModules.common-hidpi
            nixos-hardware.nixosModules.common-gpu-amd
            nixos-hardware.nixosModules.common-cpu-amd-pstate
            nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-pc-laptop
            nixos-hardware.nixosModules.common-gpu-nvidia
#            nixos-hardware.nixosModules.common-gpu-intel
./add-nvidia.nix
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
#      specialArgs = { inherit unstable; };
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
