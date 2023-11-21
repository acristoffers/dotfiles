function shrink-img
    if not set -q argv[2]
        echo "Shrinks a partition in an img file to its minimum size."
        echo "Must be a extX filesystem"
        echo ""
        echo "Usage: shrink-img file partition_number"
        echo "For example: shrink-img pi.img 2"
        return
    end

    echo Shrinking partition number $argv[2] of $argv[1]

    set -l IMG $argv[1]
    set -l PARTITION $argv[2]
    set -l PDEV /dev/loop0p$PARTITION

    # resize file system to minimum and calculate its size
    sudo losetup --partscan /dev/loop0 $IMG
    sudo e2fsck -f $PDEV
    sudo resize2fs $PDEV -M
    set -l block_count (sudo tune2fs -l $PDEV | grep 'Block count' | sed 's/[^0-9]//g')
    set -l block_size (sudo tune2fs -l $PDEV | grep 'Block size' | sed 's/[^0-9]//g')
    set -l fs_size (math $block_count \* $block_size)
    sudo losetup --detach /dev/loop0

    # resize partition to fit underlying file system
    sudo losetup --partscan /dev/loop0 $IMG
    set -l start (sudo parted /dev/loop0 unit B print --json | jq -r ".disk.partitions[$(math $PARTITION-1)].start[0:-1]")
    set -l end (math $start + $fs_size)
    sudo parted /dev/loop0 resizepart $PARTITION {$end}B
    set -l blocks (sudo parted /dev/loop0 unit s print --json | jq -r ".disk.partitions[$(math $PARTITION-1)].end[0:-1]")
    set -l block_size (sudo parted /dev/loop0 unit s print --json | jq -r '.disk["physical-sector-size"]')
    set -l end (math $blocks \* $block_size)
    sudo losetup --detach /dev/loop0
    truncate -s $end $IMG

    # make sparse files
    sudo losetup --partscan /dev/loop0 $IMG
    mkdir -p /tmp/disk_image
    sudo mount $PDEV /tmp/disk_image
    sudo fstrim -v /tmp/disk_image
    sudo umount /tmp/disk_image
    sudo losetup --detach /dev/loop0
end
