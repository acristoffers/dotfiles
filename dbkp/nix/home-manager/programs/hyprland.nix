{ config, pkgs }:

{
  enable = true;

  # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
  package = null;
  portalPackage = null;

  settings = {
    "$mod" = "SUPER";
    monitor = ",preferred,auto,1";
    exec-once = [
      "waybar"
      "com.dropbox.Client"
      "swww-daemon"
      "swww img ~/.config/background"
      "swaync"
      "blueman-applet"
      "nm-applet --indicator"
      "clipman"
    ];
    bind =
      [
        "$mod, W, killactive"
        "$mod, A, exec, fuzzel"

        "SUPER_ALT, J, exec, hyprctl switchxkblayout kanata 0"
        "SUPER_ALT, K, exec, hyprctl switchxkblayout kanata 1"
        "SUPER_ALT, L, exec, hyprctl switchxkblayout kanata 2"

        "$mod, B, exec, raise --launch com.brave.Browser --class Brave-browser"
        "$mod, D, exec, raise --launch com.discordapp.Discord --class discord"
        "$mod, E, exec, raise --launch emacs --class Emacs"
        "$mod, F, exec, raise --launch app.zen_browser.zen --class zen"
        "$mod, H, exec, raise --launch matlab --class MATLAB"
        "$mod, I, exec, raise --launch nautilus --class org.gnome.Nautilus"
        "$mod, K, exec, raise --launch ghostty --class com.mitchellh.ghostty"
        "$mod, M, exec, raise --launch org.mozilla.Thunderbird --class org.mozilla.Thunderbird"
        "$mod, N, exec, raise --launch org.signal.Signal --class Signal"
        "$mod, R, exec, raise --launch org.gnome.Fractal --class org.gnome.Fractal"
        "$mod, S, exec, raise --launch org.kde.okular --class org.kde.okular"
        "$mod, T, exec, raise --launch org.telegram.desktop --class org.telegram.desktop"
        "$mod, U, exec, raise --launch org.keepassxc.KeePassXC --class org.keepassxc.KeePassXC"
        "$mod, Z, exec, raise --launch org.zotero.Zotero --class org.zotero.Zotero"

        "$mod, V, exec, app.zen_browser.zen --new-tab 'https://search.brave.com'"
        "$mod, Y, exec, app.zen_browser.zen --new-tab 'https://youtube.com'"
        "$mod, J, exec, nautilus ~/Downloads"

        # Foco
        "SUPER_CTRL,h,movefocus,l"
        "SUPER_CTRL,l,movefocus,r"
        "SUPER_CTRL,k,movefocus,u"
        "SUPER_CTRL,j,movefocus,d"

        # Mover janela
        "SUPER_SHIFT,h,movewindow,l"
        "SUPER_SHIFT,l,movewindow,r"
        "SUPER_SHIFT,k,movewindow,u"
        "SUPER_SHIFT,j,movewindow,d"

        # Floating mode
        "SUPER,space,togglefloating"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList
          (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ])
          9)
      );
    # Natural scroll for touchpad
    input = {
      touchpad = {
        natural_scroll = true;
      };
      kb_layout = "us,us,ru";
      kb_variant = ",intl,";
    };
    # Faster animations
    animation = [
      "windows, 1, 2, default"
      "border, 1, 2, default"
      "fade, 1, 2, default"
      "workspaces, 1, 2, default"
    ];
    # 8px gaps
    general = {
      gaps_in = 8;
      gaps_out = 8;
    };
  };
}
