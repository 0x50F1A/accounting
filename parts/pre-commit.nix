{ lib, pkgs, ... }:
{
  pre-commit = {
    check.enable = false;
    settings = {
      excludes = [
        "license.md"
        "id_ed25519"
        "id_ed25519.agekey"
      ];
      hooks = {
        hledger-unmarked-checking = {
          enable = true;
          always_run = true;
          name = "hledger-unmarked-checking";
          description = "Checks for unmarked transactions in hledger files";
          files = "(^|/)postings\.ledger$";
          entry = "${lib.getExe pkgs.nushell} ./parts/unmarked.nu";
        };
        hledger-checking = {
          enable = true;
          always_run = true;
          name = "hledger-checking";
          description = "Runs all hledger checks";
          files = "book\.ledger$";
          entry = "${lib.getExe pkgs.bash} -c 'for x in \"$@\"; do ${lib.getExe pkgs.hledger} check --strict ordereddates payees tags recentassertions uniqueleafnames --file \"$x\"; done' --";
        };
        check-added-large-files.enable = true;
        check-case-conflicts.enable = true;
        check-shebang-scripts-are-executable.enable = true;
        check-symlinks.enable = true;
        check-toml.enable = true;
        check-vcs-permalinks.enable = true;
        check-yaml.enable = true;
        convco.enable = true;
        deadnix = {
          enable = true;
        };
        detect-private-keys.enable = true;
        eclint = {
          enable = true;
          excludes = [ "flake.lock" ];
        };
        fix-byte-order-marker.enable = true;
        flake-checker.enable = true;
        forbid-new-submodules.enable = true;
        headache.enable = true;
        hunspell = {
          enable = false;
        };
        lychee = {
          enable = true;
          excludes = [ ".lychee.toml" ];
          settings = {
            configPath = ".lychee.toml";
          };
        };
        markdownlint = {
          enable = true;
        };
        nil.enable = true;
        pre-commit-hook-ensure-sops.enable = false;
        ripsecrets.enable = true;
        single-quoted-strings.enable = true;
        sort-simple-yaml = {
          enable = true;
          excludes = [ ];
        };
        statix = {
          enable = false;
        };
        tagref.enable = false;
        trim-trailing-whitespace.enable = true;
        treefmt.enable = true;
        vale = {
          enable = false;
          excludes = [
            "\.nix$"
            "\.toml$"
            "\.yml$"
          ];
          files = "\.md$";
        };
        yamllint = {
          enable = true;
        };
      };
    };
  };
}
