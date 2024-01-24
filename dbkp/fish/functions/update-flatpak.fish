function update-flatpak
  if test (uname -s) != "Linux"
    return
  end

  if not type -q "flatpak"
    return
  end

  title Updating Flatpak

  flatpak update -y
end
