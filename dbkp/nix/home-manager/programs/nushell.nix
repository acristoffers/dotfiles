{ config, pkgs }:

{
  enable = true;
  configFile.text = ''
    $env.config = {
      show_banner: false,
    }
    use ~/.cache/starship/init.nu
  '';
}
