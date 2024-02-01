function cfp --argument file_name
  set -l cwd (pwd)/$file_name
  if test -e $cwd
    printf $cwd | pbcopy
  else
    printf $file_name | pbcopy
  end
end
