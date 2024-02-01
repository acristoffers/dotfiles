function pbcopy
  if test (uname -s) = "Darwin"
    command pbcopy $argv
  else
    read -lz input
    printf $input | string-trim | xclip -sel clip
  end
end
