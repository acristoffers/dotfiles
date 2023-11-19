{ pkgs, lib, ... }:

{
  nix.package = pkgs.nix;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  users.users.alan = {
    name = "alan";
    home = "/Users/alan";
  };

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Meslo" "Inconsolata" ]; })
  ];

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    global.autoUpdate = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";
    onActivation.upgrade = true;
    masApps = {
      CleanMyDrive = 523620159;
      Bitwarden = 1352778147;
      Numbers = 409203825;
      Overlap = 1516950324;
      Xcode = 497799835;
      Pages = 409201541;
      Developer = 640199958;
      iMovie = 408981434;
      Hour = 569089415;
      Pixelmator = 1289583905;
      Keynote = 409183694;
    };
    casks = [
      "adobe-acrobat-reader"
      "authy"
      "blackhole-16ch"
      "discord"
      "dropbox"
      "element"
      "fedora-media-writer"
      "firefox"
      "flutter"
      "font-latin-modern"
      "font-latin-modern-math"
      "github"
      "gpg-suite-no-mail"
      "grammarly"
      "hammerspoon"
      "iterm2"
      "julia"
      "karabiner-elements"
      "keka"
      "keycastr"
      "keystore-explorer"
      "lachesis"
      "little-snitch"
      "mactex"
      "microsoft-auto-update"
      "microsoft-office"
      "netnewswire"
      "pdf-expert"
      "pocket-casts"
      "protonvpn"
      "rar"
      "raycast"
      "signal"
      "skim"
      "spotify"
      "steam"
      "telegram"
      "temurin"
      "vlc"
      "xquartz"
      "zotero"
      "zulu"
      "zulu8"
      "zulufx"
    ];
    brews = [
      "blueutil"
      "clang-format"
      "ghostscript"
      "grip"
      "jenv"
      "mas"
      "mongodb/brew/mongodb-community"
      "pidof"
      "snapcraft"
      "tty-clock"
    ];
    taps = [
      "acristoffers/repo"
      "apenngrace/vulkan"
      "dart-lang/dart"
      "homebrew-ffmpeg/ffmpeg"
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/core"
      "homebrew/services"
      "mongodb/brew"
      "railwaycat/emacsmacport"
      "str4d.xyz/rage"
    ];
  };
}
