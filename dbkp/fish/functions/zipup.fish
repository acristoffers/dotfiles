function zipup
  set f $argv[1]
  zip -9 -r (basename $argv[1]) (basename $argv[1])
end
