# Defined in /Users/Alan/.config/fish/config.fish @ line 146
function git-merge-and-push
  git merge master
  and git checkout master
  and git merge alan
  and git push
  and git push --tags
  and git checkout alan
end
