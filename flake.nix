{
  description = "Customized Iosevka Fonts";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    nerd-fonts-font-patcher = {
      url = "file+https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem =
        { pkgs, self', ... }:
        let
          font-patcher = pkgs.callPackage ./extract-font-patcher.nix {
            font-patcher-zip = inputs.nerd-fonts-font-patcher;
          };
        in
        {
          packages.default = pkgs.callPackage ./package.nix { };
          packages.nerd-fonts = pkgs.callPackage ./nerd-font-patcher.nix {
            font = self'.packages.default;
            inherit font-patcher;
          };
          packages.nerd-fonts-mono = pkgs.callPackage ./nerd-font-patcher.nix {
            font = self'.packages.default;
            mono-variant = true;
            inherit font-patcher;
          };
          packages.complete = pkgs.callPackage ./merge-fonts.nix {
            fonts = with self'.packages; [
              default
              nerd-fonts
              nerd-fonts-mono
            ];
          };

          devShells.default = pkgs.mkShell {
            packages = [ pkgs.fontforge ];
            shellHook = ''
              ln -s ${font-patcher} .font-patcher
            '';
          };
        };
    };
}
