# Defined in /var/folders/7b/jjzx_8kj59s172r3j3g5yy400000gn/T//fish.NFlxK3/fish_prepend_clear.fish @ line 2
function fish_prepend_clear
    set -l cmd (commandline)
    if ! string match -qr "^[ ]*clear[ ]*;" $cmd[1]
        set -l len (string length $cmd[1])
        set -l cmd[1] (string trim -l $cmd[1])
        set -l pos (math 7 + (commandline -C)[1] - $len + (string length $cmd[1]))
        set -l cmd[1] (string trim -r $cmd[1])
        set -l cmd[1] "clear; "$cmd[1]
        commandline -r $cmd
        commandline -C $pos
    else
        set -l pos (commandline -C)
        set -l len (string length (string match -r "^[ ]*clear[ ]*;[ ]*" $cmd[1]))
        set -l cmd[1] (string trim (string replace -r "^[ ]*clear[ ]*;[ ]*" "" $cmd[1]))
        commandline -r $cmd
        commandline -C (math "max($pos-$len, 0)")
    end
end
