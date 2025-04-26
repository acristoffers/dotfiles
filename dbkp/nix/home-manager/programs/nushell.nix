{ config, pkgs, inputs }:

{
  enable = true;
  configFile.text = ''
    $env.config = {
      show_banner: false,
      float_precision: 4,
    }

    use ~/.cache/starship/init.nu
    source ${inputs.nu-scripts}/themes/nu-themes/catppuccin-mocha.nu

    use ${inputs.nu-scripts}/modules/docker

    source ${inputs.nu-scripts}/custom-completions/bat/bat-completions.nu
    source ${inputs.nu-scripts}/custom-completions/bitwarden-cli/bitwarden-cli-completions.nu
    source ${inputs.nu-scripts}/custom-completions/cargo/cargo-completions.nu
    source ${inputs.nu-scripts}/custom-completions/cargo-make/cargo-make-completions.nu
    source ${inputs.nu-scripts}/custom-completions/curl/curl-completions.nu
    source ${inputs.nu-scripts}/custom-completions/docker/docker-completions.nu
    source ${inputs.nu-scripts}/custom-completions/eza/eza-completions.nu
    source ${inputs.nu-scripts}/custom-completions/flutter/flutter-completions.nu
    source ${inputs.nu-scripts}/custom-completions/gh/gh-completions.nu
    source ${inputs.nu-scripts}/custom-completions/git/git-completions.nu
    source ${inputs.nu-scripts}/custom-completions/just/just-completions.nu
    source ${inputs.nu-scripts}/custom-completions/less/less-completions.nu
    source ${inputs.nu-scripts}/custom-completions/make/make-completions.nu
    source ${inputs.nu-scripts}/custom-completions/man/man-completions.nu
    source ${inputs.nu-scripts}/custom-completions/nix/nix-completions.nu
    source ${inputs.nu-scripts}/custom-completions/npm/npm-completions.nu
    source ${inputs.nu-scripts}/custom-completions/pnpm/pnpm-completions.nu
    source ${inputs.nu-scripts}/custom-completions/rg/rg-completions.nu
    source ${inputs.nu-scripts}/custom-completions/rustup/rustup-completions.nu
    source ${inputs.nu-scripts}/custom-completions/ssh/ssh-completions.nu
    source ${inputs.nu-scripts}/custom-completions/tar/tar-completions.nu
    source ${inputs.nu-scripts}/custom-completions/tealdeer/tldr-completions.nu
  '';
}
