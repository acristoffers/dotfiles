function fish_append_null_redirect
    set -l cmd (string trim (commandline -p))
    set -l last_char (commandline | string sub -l 1 -s (math "max(1,$(commandline -C)-$(commandline -pC))"))
    if not string match -qr '&>/dev/null$' $cmd
        commandline -pa ' &>/dev/null'
    else
        set -l pos (commandline -pC)
        set -l len (string length (string match -r '&>/dev/null$' $cmd))
        set -l cmd (string trim (string replace -r '&>/dev/null$' "" $cmd))
        if string match -rq "[|;]" "$last_char"
            set cmd " $cmd"
            set pos (math 1 + $pos)
        end
        commandline -pr $cmd
        commandline -pC (math "max($pos-$len, 0)")
    end
end
