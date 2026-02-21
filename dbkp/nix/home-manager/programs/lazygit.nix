{ config, pkgs }:

{
  enable = true;
  settings = {
    gui = {
      nerdFontsVersion = "3";
      authorColors = {
        "Álan e Sousa" = "#F28C28";
        "Álan Crístoffer e Sousa" = "#F28C28";
        "Álan Crístoffer" = "#F28C28";
     };
      branchColors = {
        "bugfix" = "yellow";
        "chore" = "#F28C28";
        "experimental" = "#8BE9FD";
        "feat" = "green";
        "feature" = "green";
        "fix" = "yellow";
        "hotfix" = "red";
        "refactor" = "green";
        "support" = "#F28C28";
        "integration" = "#8BE9FD";
      };
    };
    git = {
      mainBranches = [ "main" "master" "develop" ];
      pagers = [
        {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        }
      ];
    };
    os = {
      editPreset = "nvim";
    };
    promptToReturnFromSubprocess = false;
  };
}
