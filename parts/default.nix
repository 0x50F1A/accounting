{ inputs, ... }:
{
  imports = [
    inputs.flake-root.flakeModule
    inputs.pre-commit-hooks-nix.flakeModule
    inputs.treefmt-nix.flakeModule
  ];
  perSystem =
    { pkgs, ... }:
    {
      imports = [
        ./devShells.nix
        ./pre-commit.nix
        ./treefmt.nix
      ];

      packages = {
        paisa = inputs.paisa.packages.${pkgs.system}.default;
        puffin = pkgs.buildGoModule {
          pname = "puffin";
          version = "git";

          src = inputs.puffin;
          vendorHash = "sha256-XfsGXh9nz+QJEAqtw/BfzHhSVje6q0KLsVg1ZQ6fN4U=";

          meta = {
            homepage = "https://github.com/siddhantac/puffin";
            description = "Beautiful terminal dashboard for hledger";
            license = pkgs.lib.licenses.mit;
          };
        };
      };
    };
}
