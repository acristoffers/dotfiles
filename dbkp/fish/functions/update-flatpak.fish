function update-flatpak
  if not type -q "flatpak"
    return
  end

  title Updating Flatpak

  flatpak update -y
end
