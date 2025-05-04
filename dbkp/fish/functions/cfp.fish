function cfp --argument file_name
  set -l cwd (pwd)/$file_name
  if test -e $cwd
    printf $cwd | wl-copy
  else
    printf $file_name | wl-copy
  end
end
