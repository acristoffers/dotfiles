function rwhich
    readlink -f (which $argv)
end
