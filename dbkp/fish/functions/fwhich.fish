function fwhich
    file (readlink -f (which $argv))
end
