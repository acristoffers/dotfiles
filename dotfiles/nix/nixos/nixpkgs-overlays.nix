let
  gnome-sessions-overlay = final: prev: {
    gnome = prev.gnome // {
      gnome-session = prev.gnome.gnome-session.overrideAttrs (old: {
        postInstall = ''
          mkdir $sessions
          moveToOutput share/wayland-sessions "$sessions"
          rm -rf $out/share/xsessions
          rm -rf $out/libexec/gnome-session-ctl
        '';
        passthru = old.passthru // { providedSessions = [ "gnome" "gnome-wayland" ]; };
      });
    };
  };
in
# [ gnome-sessions-overlay ]
[]
