{
  description = "Minimal standalone nixvim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
    }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAll = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      packages = forAll (system: rec {
        default = nvim;
        nvim =
          (nixvim.lib.evalNixvim {
            inherit system;
            modules = [ ./config.nix ];
          }).config.build.package;
      });
    };
}
