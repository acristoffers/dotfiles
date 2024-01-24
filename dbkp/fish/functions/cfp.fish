function cfp --argument file_name
  set -l cwd (pwd)/$file_name
  if test -e $cwd
    string trim $cwd | pbcopy
  else
    string trim $file_name | pbcopy
  end
end
