function update -d "Updates many package managers."
  argparse 'd/debug' -- $argv

  if test (count $argv) -gt 0
    for command in $argv
      if type -q "update-$command"
        fish -c "update-$command $_flag_debug"
      else
        echo $command is not recognized >&2
      end
    end
    return
  end

  # title "Removing Trash Files"
  # command remove-trash --no-error ~
  # echo

  rm -rf ~/.cache/nix
  if which cancel &>/dev/null
    cancel -a -x # Deletes cups temp files (it leaves shit around ¬¬)
  end

  update-apt
  update-dnf
  update-flatpak
  update-nix $_flag_debug
  update-brew
  update-pip3
  update-tlmgr
  update-rustup
  update-flutter
  update-doom

  if test (date -u +%u) = 1
    if not test -e ~/.local/state/nixgc
      nix-collect-garbage -d
      sudo journalctl --flush --rotate --vacuum-time=1s
      touch ~/.local/state/nixgc
    end
  else
    if test -e ~/.local/state/nixgc
      rm ~/.local/state/nixgc
    end
  end

  wait
end
