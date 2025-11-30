function thunderbird-backup
  rsync -a --delete ~/.var/app/org.mozilla.Thunderbird /mnt/backup/thunderbird/current/
  sudo btrfs subvolume snapshot /mnt/backup/thunderbird/current /mnt/backup/thunderbird/(date +"%Y-%m-%dT%H:%M")
end
