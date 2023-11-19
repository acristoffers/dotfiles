function update-kernel
    if test (uname -s) != "Linux"
        return
    end

    title Updating Bootloader

    pushd /boot
    sudo rm -r *
    sudo rm -r .*

    set -l latest (printf '%s\n' (ls /lib/modules) | sort -V | tail -n1)

    echo "Generating images for $latest (current is "(uname -r)")"

    sudo kernel-install add $latest /lib/modules/$latest/vmlinuz
    sudo mv initramfs-$latest.img initramfs.img
    sudo mv vmlinuz-$latest vmlinuz.img
    sudo mv .vmlinuz-$latest.hmac .vmlinuz.hmac
    sudo (which rmbut) -r initramfs.img vmlinuz.img .vmlinuz.hmac efi

    popd
end
