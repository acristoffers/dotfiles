function update-brew
    if test (uname -s) != "Darwin"
        return
    end

    title Updating Homebrew

    brew update
    brew upgrade --formula
    brew upgrade --cask

    # Removing the downloads folder causes problems when upgrading some packages
    if brew outdated | grep -q emacs-mac
        brew uninstall --formula emacs-mac
        brew install --formula emacs-mac --with-glib --with-imagemagick \
            --with-mac-metal --with-native-comp --with-librsvg \
            --with-natural-title-bar --with-starter
    end

    if brew outdated | grep -q zulu
        set -l outdated_zulu (brew outdated | grep zulu)
        for zulu in $outdated_zulu
            brew uninstall $zulu
            brew install $zulu
        end
    end

    if brew outdated | grep -q temurin
        set -l outdated_temurin (brew outdated | grep temurin)
        for temurin in $outdated_temurin
            brew uninstall $temurin
            brew install $temurin
        end
    end

    brew autoremove
    brew cleanup --prune=all

    brew fixlinks
    pushd ~/Library/Caches/Homebrew
    rmbut -r Cask
    popd
end
