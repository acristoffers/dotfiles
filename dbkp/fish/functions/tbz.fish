# Defined in /var/folders/25/by_gngxd5sv134wdn951h_2r0000gn/T//fish.JIKdYL/tbz.fish @ line 2
function tbz
    set f $argv[1]
    tar --sort=name \
        --mtime=@0 \
        --owner=0 --group=0 --numeric-owner \
        --pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime \
        -c (basename $f) | bzip2 -9 >(basename $f).tbz
end
