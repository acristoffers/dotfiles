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
        "support" = "#F28C28";
        "integration" = "#8BE9FD";
      };
    };
    customCommands = [
      {
        key = "n";
        context = "localBranches";
        prompts = [
          {
            type = "menu";
            title = "What kind of branch is it?";
            key = "BranchType";
            options = [
              { name = "feature"; description = "a feature branch"; value = "feature/"; }
              { name = "bugfix"; description = "a bugfix branch"; value = "bugfix/"; }
              { name = "hotfix"; description = "a hotfix branch"; value = "hotfix/"; }
              { name = "integration"; description = "an integration branch"; value = "integration/"; }
              { name = "experimental"; description = "an experimental branch"; value = "experimental/"; }
              { name = "other"; description = "other"; value = ""; }
            ];
          }
          {
            type = "input";
            title = "What is the new branch name?";
            key = "BranchName";
            initialValue = "";
          }
        ];
        command = "git switch --create {{.Form.BranchType}}{{.Form.BranchName}}";
        loadingText = "Creating branch";
      }
      {
        key = "P";
        context = "global";
        prompts = [
          {
            type = "menu";
            title = "What kind of push?";
            key = "PushOptions";
            options = [
              { name = "regular"; description = "regula push"; value = ""; }
              { name = "force"; description = "force push"; value = "--force-with-lease"; }
              { name = "no-ci"; description = "no CI"; value = "-o ci.skip"; }
              { name = "force-no-ci"; description = "no CI (force)"; value = "-o ci.skip --force-with-lease"; }
              { name = "break-cache"; description = "break cache"; value = "-o ci.input=break-cache=true"; }
              { name = "force-break-cache"; description = "break cache (force)"; value = "-o ci.input=break-cache=true --force-with-lease"; }
              { name = "release"; description = "release"; value = "-o ci.input=build-release=true"; }
              { name = "force-release"; description = "release (force)"; value = "-o ci.input=build-release=true --force-with-lease"; }
              { name = "break-and-release"; description = "break cache and build release"; value = "-o ci.input=build-release=true -o ci.input=break-cache=true"; }
              { name = "force-break-and-release"; description = "break cache and build release (force)"; value = "-o ci.input=build-release=true -o ci.input=break-cache=true --force-with-lease"; }
            ];
          }
        ];
        command = "git push {{.Form.PushOptions}}";
        loadingText = "Creating branch";
      }
      {
        key = "c";
        description = "Toggle [skip ci]";
        context = "commits";
        command = ''
          #!/usr/bin/env fish
          if git log -1 --pretty=%B | string match -eiq '[skip ci]'
            git log -1 --pretty=%B | sed "/\[skip ci\]/d" | git commit --amend -F -
          else
            echo -e "$(git log -1 --pretty=%B)\n\n[skip ci]" | git commit --amend -F -
          end
        '';
        loadingText = "Toggling [skip ci]";
      }
    ];
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
