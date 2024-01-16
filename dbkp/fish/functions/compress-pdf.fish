# Defined in /Users/Alan/.config/fish/config.fish @ line 110
function compress-pdf
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$argv[2]" "$argv[1]"
end
