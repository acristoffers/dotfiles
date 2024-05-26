function fix-path
  set -l tmp $PATH
  set -Ux PATH /bin
  for path in {,/usr}{,/local}{/sbin,/bin}
    add-to-path-if-exists $path
  end
  for path in $tmp
    add-to-path-if-exists $path
  end
end
