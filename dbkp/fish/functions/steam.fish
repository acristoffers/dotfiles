function steam --wraps='eval (fd steam-bwrap /nix/store | rg -v drv)' --description 'alias steam eval (fd steam-bwrap /nix/store | rg -v drv)'
  eval (fd steam-bwrap /nix/store | rg -v drv) $argv
        
end
