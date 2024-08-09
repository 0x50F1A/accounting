{ ... }:
{
  pre-commit = {
    check.enable = false;
    settings = {
      excludes = [ "./license.md" ];
      hooks = {
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
          enable = false;
          excludes = [ ".lychee.toml" ];
          settings = {
            configPath = ".lychee.toml";
          };
        };
        markdownlint = {
          enable = true;
        };
        nil.enable = true;
        pre-commit-hook-ensure-sops.enable = true;
        ripsecrets.enable = true;
        single-quoted-strings.enable = true;
        sort-simple-yaml = {
          enable = true;
          excludes = [ ];
        };
        statix = {
          enable = false;
        };
        tagref.enable = true;
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
