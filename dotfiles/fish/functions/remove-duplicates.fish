function remove-duplicates
    for file in $argv
        set checksum (sha256sum $file | awk '{print $1}')
        if contains $checksum $ss
            rm $file
        else
            set ss $ss $checksum
        end
    end
end
