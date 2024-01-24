function fish_prepend_sudo
  set -l cmd (commandline -p)
  set last_char (commandline | string sub -l 1 -s (math "max(1,$(commandline -C)-$(commandline -pC))"))
  if ! string match -qr "^[ ]*sudo" $cmd
    set -l len (string length $cmd)
    set -l cmd (string trim -l $cmd)
    set -l pos (math 5 + (commandline -pC) - $len + (string length $cmd))
    set -l cmd (string trim -r $cmd)
    set -l cmd "sudo $cmd"
    commandline -pC 0
    if string match -rq "[|;]" "$last_char"
      set cmd " $cmd"
      set pos (math 1 + $pos)
    end
    commandline -rp $cmd
    commandline -pC $pos
  else
    set -l pos (commandline -pC)
    set -l len (string length (string match -r "^[ ]*sudo[ ]*" $cmd))
    set -l cmd (string trim (string replace -r "^[ ]*sudo[ ]*" "" $cmd))
    commandline -pC 0
    if string match -rq "[|;]" "$last_char"
      set cmd " $cmd"
      set pos (math 1 + $pos)
    end
    commandline -pr $cmd
    commandline -pC (math "max($pos-$len, 0)")
  end
end
