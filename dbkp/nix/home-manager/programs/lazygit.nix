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
        # Coworkers
        "Andres Gutierrez" = "#FF79C6";
        "Anthony Welte" = "#8BE9FD";
        "Antonin Renoir" = "#50FA7B";
        "Etienne Clairis" = "#BD93F9";
        "Ganesh Harishankarlaldas" = "#FF5555";
        "Guillaume Bourgeois" = "#F1FA8C";
        "Guillermo Herrera" = "#6272A4";
        "Khadidja Ouldamer" = "#44475A";
        "Samuele Portanti" = "#FFB86C";
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
      };
    };
    git = {
      mainBranches = [ "main" "develop" "master" ];
    };
    promptToReturnFromSubprocess = false;
  };
}
