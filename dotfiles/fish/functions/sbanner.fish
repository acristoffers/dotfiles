# Defined in /var/folders/7b/jjzx_8kj59s172r3j3g5yy400000gn/T//fish.caC51K/sbanner.fish @ line 2
function sbanner
    while true
        clear
        string repeat -n (math floor\(\((tput lines) - 18\)/2\)) \n
        neofetch --os_arch off --disable term_font cols
        sleep 600
    end
    clear
end
