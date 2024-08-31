{ config, pkgs }:

{
  enable = true;
  configFile.text = ''
    use ~/.cache/starship/init.nu
  '';
}
