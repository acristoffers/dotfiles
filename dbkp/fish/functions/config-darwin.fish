function config-darwin
    set -U tide_os_icon 

    add-to-path-if-exists /opt/homebrew/bin
    add-to-path-if-exists /opt/homebrew/sbin

    set -gx BREW (brew --prefix)
    set -gx ANDROID_SDK_ROOT $HOME/Library/Android/sdk
    set -gx PGDATA $BREW/var/postgres
    set -gx RUNFILES_DIR $BREW/share/plaidml
    set -gx PLAIDML_NATIVE_PATH $BREW/lib/libplaidml.dylib
    set -gx HOMEBREW_CASK_OPTS "--no-quarantine"
    set -gx FIREBIRD_HOME /Library/Frameworks/Firebird.framework/Resources
    set -gx VLC_PLUGIN_PATH /Applications/VLC.app/Contents/MacOS/plugins/
    set -gx DYLD_LIBRARY_PATH /Users/alan/.rustup/toolchains/stable-aarch64-apple-darwin/lib ~/.nix-profile/lib* ~/.nix-profile/lib/gcc/*/*
    set -gx PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
    set -gx PUPPETEER_EXECUTABLE_PATH '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
    set -gx GRB_LICENSE_FILE /Users/alan/Documents/gurobi/gurobi.lic
    set -gx DISPLAY "" # So VIM stops opening XQuartz
    set -gx NIX_PATH "$HOME/.nix-defexpr/channels:darwin=$HOME/.nix-defexpr/darwin:darwin-config=$XDG_CONFIG_HOME/home-manager/darwin.nix"

    if not set -q FULL_NIX_SHELL
        set -gax PKG_CONFIG_PATH $BREW/opt/*/lib/pkgconfig
    end

    set -l index (contains -i $HOME/.nix-profile/bin $PATH)
    set --erase PATH[$index]

    add-to-path-if-exists $HOME/bin/darwin
    add-to-path-if-exists $HOME/.nix-profile/bin
    add-to-path-if-exists "$HOME/Library/Android/sdk/build-tools/*"
    add-to-path-if-exists $HOME/Library/Android/sdk/emulator
    add-to-path-if-exists $HOME/Library/Android/sdk/cmdline-tools/latest/bin
    add-to-path-if-exists $HOME/Library/Android/sdk/platform-tools
    add-to-path-if-exists $HOME/Library/Android/sdk/tools
    add-to-path-if-exists $HOME/.bin/flutter/bin
    add-to-path-if-exists $BREW/opt/e2fsprogs/bin
    add-to-path-if-exists $BREW/opt/e2fsprogs/sbin
    add-to-path-if-exists $HOME/.bin/mosek/10.0/tools/platform/osx64x86/bin
    add-to-path-if-exists $BREW/opt/qt/bin
    add-to-path-if-exists "/Applications/MATLAB*/bin/maci64"
    add-to-path-if-exists "/Applications/MATLAB*/Contents/MacOS"
    add-to-path-if-exists $BREW/opt/grep/libexec/gnubin
    add-to-path-if-exists $FIREBIRD_HOME/bin
    add-to-path-if-exists /Library/TeX/texbin
    add-to-path-if-exists /run/current-system/sw/bin
    add-to-path-if-exists /nix/var/nix/profiles/default/bin

    if status --is-interactive
        source (jenv init - | psub)
        set -gx JAVA_HOME (jenv prefix)
    end

    ssh-add ~/.ssh/key &>/dev/null
end
