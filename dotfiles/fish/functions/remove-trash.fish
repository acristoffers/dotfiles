# Defined in /var/folders/25/by_gngxd5sv134wdn951h_2r0000gn/T//fish.oIe3Ly/remove-trash.fish @ line 1
function remove-trash
  set files (find $argv[1] -name .DS_Store           \
                           -or -name Thumbs.db       \
                           -or -iname '~*'           \
                           -or -iname '*.bak'        \
                           -or -iname '.sass-cache'  \
                           -or -iname '__pycache__'  \
                           -or -iname '.textpadtmp')
  set total 0
  for file in $files
    if test -e $file
      set size (du -csk $file | awk '{print $1}' | tail -n 1)
      set total (math $total + $size)
      rm -rf $file
    end
  end
  set i 1
  while test $total -gt 1024
    set total (math -s2 $total / 1024)
    set i (math $i + 1)
  end
  set suffixes K M G T
  echo Freed $total$suffixes[$i]
end
