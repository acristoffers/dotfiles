function update-apt
  if test (uname -s) != "Linux"
    return
  end

  if not type -q "apt-get"
    return
  end

  title Updating Aptitude

  sudo apt update -y
  sudo apt upgrade -y
  sudo apt full-upgrade -y
  sudo apt autoremove -y
  sudo apt clean -y

  mkdir -p ~/.config/plasma-workspace/env
  echo "export PATH=$PATH" > ~/.config/plasma-workspace/env/env.sh
  echo "export XDG_DATA_DIRS=$XDG_DATA_DIRS" >> ~/.config/plasma-workspace/env/env.sh
end
