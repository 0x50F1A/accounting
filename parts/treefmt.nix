{
  treefmt = {
    flakeCheck = false;
    programs = {
      nixfmt = {
        enable = true;
      };
      taplo = {
        enable = true;
      };
      yamlfmt = {
        enable = true;
      };
    };
    projectRootFile = "flake.nix";
    settings = {
      formatter = {
        yamlfmt = {
          options = [
            "-formatter"
            "include_document_start=true"
          ];
        };
      };
    };
  };
}
