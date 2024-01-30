function pbcopy
  if test (uname -s) = "Darwin"
    command pbcopy $argv
  else
    read -lz input
    string trim -- $input | xclip -sel clip
  end
end
