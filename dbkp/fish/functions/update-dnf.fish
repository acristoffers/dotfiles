function update-dnf
  if test (uname -s) != "Linux"
    return
  end

  if not which "dnf" &>/dev/null
    return
  end

  title Updating Fedora

  sudo dnf -y --refresh upgrade
  sudo dnf -y autoremove
  sudo dnf -y clean all

  mkdir -p ~/.config/plasma-workspace/env
  echo "export PATH=$PATH" > ~/.config/plasma-workspace/env/env.sh
  echo "export XDG_DATA_DIRS=$XDG_DATA_DIRS" >> ~/.config/plasma-workspace/env/env.sh
end
