{
  description = "An inactive Discord server member monitor";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      eachSystem = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = eachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          packages.default = pkgs.mkShell {
            packages = [
              pkgs.python3Packages.nextcord
              pkgs.python3Packages.pytz
              self.packages.${system}.default
            ];
          };
        }
      );
      nixosModules.adiosBot =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        import ./module.nix {
          inherit config lib pkgs;
          adiosBot = self.packages.${pkgs.system}.adiosBot;
        };
      nixosModules.default = self.nixosModules.adiosBot;
      packages = eachSystem (system: {
        default = self.packages.${system}.adiosBot;
        adiosBot = nixpkgs.legacyPackages.${system}.callPackage ./package.nix { };
      });
    };
}
