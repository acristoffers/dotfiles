function pbcopy
  if test (uname -s) = "Darwin"
    command pbcopy $argv
  else
    read -lz input
    printf $input | perl -ne 'chomp; print $_ =~ s/^\s+|\s+$//gr' | xclip -sel clip
  end
end
