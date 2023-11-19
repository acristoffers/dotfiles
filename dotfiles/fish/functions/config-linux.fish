function config-linux
    if lsb_release -i | grep -q Steam
        set -U tide_os_icon 󰓓
    else if lsb_release -i | grep -q NixOS
        set -U tide_os_icon 
    else
        set -U tide_os_icon 
    end

    alias dnf "sudo --user=alan dnf"

    abbr klogout   "qdbus org.kde.Shutdown /Shutdown logout"
    abbr kreboot   "qdbus org.kde.Shutdown /Shutdown logoutAndReboot"
    abbr kshutdown "qdbus org.kde.Shutdown /Shutdown logoutAndShutdown"
    abbr pbpaste   "xclip -sel clip -out"

    set -gx LOCALE_ARCHIVE /usr/lib/locale/locale-archive
    set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
    set -gx XCOMPOSEFILE "$XDG_CONFIG_HOME"/X11/xcompose

    for p in $LD_LIBRARY_EXTRA_PATH
        set -a LD_LIBRARY_PATH $p
    end

    add-to-path-if-exists /var/lib/snapd/snap/bin

    # Prevents messages about degraded session in home-manager
    systemctl --user reset-failed
end
