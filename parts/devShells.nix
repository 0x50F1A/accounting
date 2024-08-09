{
  config,
  lib,
  pkgs,
  self',
  ...
}:
{
  devShells = {
    default = pkgs.mkShell {
      name = "nixos";
      meta.description = "Standard Development Environment";
      inputsFrom = [
        config.pre-commit.devShell
        config.treefmt.build.devShell
      ];
      packages = builtins.attrValues {
        inherit (self'.packages) paisa puffin;
        inherit (pkgs) git-agecrypt hledger;
      };
      shellHook = ''
        FLAKE_ROOT="''$(${lib.getExe config.flake-root.package})"
        export FLAKE_ROOT
        LEDGER_FILE="$FLAKE_ROOT/hledger.journal"
        export LEDGER_FILE
        PAISA_CONFIG="$FLAKE_ROOT/paisa.yaml"
        export PAISA_CONFIG
      '';
    };
  };
}
