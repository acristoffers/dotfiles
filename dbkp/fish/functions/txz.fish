function txz
  set f $argv[1]
  tar -c (basename $f) | xz -9 -T 0 > (basename $f).txz
end
