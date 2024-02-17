function txz
    set f $argv[1]
    tar --sort=name \
        --mtime=@0 \
        --owner=0 --group=0 --numeric-owner \
        --pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime \
        -c (basename $f) | xz -9 -T 8 >(basename $f).txz
end
