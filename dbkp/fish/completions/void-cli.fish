complete -c void-cli -n "__fish_use_subcommand" -s p -l password -r
complete -c void-cli -n "__fish_use_subcommand" -s h -l help -d 'Print help information (use `--help` for more detail)'
complete -c void-cli -n "__fish_use_subcommand" -s V -l version -d 'Print version information'
complete -c void-cli -n "__fish_use_subcommand" -f -a "create" -d 'Creates a new store'
complete -c void-cli -n "__fish_use_subcommand" -f -a "add" -d 'Adds a file or folder to the store'
complete -c void-cli -n "__fish_use_subcommand" -f -a "get" -d 'Get a file or folder from the store (unencrypts it)'
complete -c void-cli -n "__fish_use_subcommand" -f -a "rm" -d 'Removes a file or folder from the store'
complete -c void-cli -n "__fish_use_subcommand" -f -a "ls" -d 'List files in the store'
complete -c void-cli -n "__fish_use_subcommand" -f -a "metadata-set" -d 'Set file metadata'
complete -c void-cli -n "__fish_use_subcommand" -f -a "metadata-get" -d 'Get file metadata'
complete -c void-cli -n "__fish_use_subcommand" -f -a "metadata-list" -d 'List file metadata'
complete -c void-cli -n "__fish_use_subcommand" -f -a "metadata-remove" -d 'Remove file metadata'
complete -c void-cli -n "__fish_use_subcommand" -f -a "tag-add" -d 'Add node tag'
complete -c void-cli -n "__fish_use_subcommand" -f -a "tag-remove" -d 'Remove node tag'
complete -c void-cli -n "__fish_use_subcommand" -f -a "tag-get" -d 'Get node tags'
complete -c void-cli -n "__fish_use_subcommand" -f -a "tag-clear" -d 'Get node tags'
complete -c void-cli -n "__fish_use_subcommand" -f -a "tag-list" -d 'List tags in the filesystem'
complete -c void-cli -n "__fish_use_subcommand" -f -a "tag-search" -d 'List nodes with tags'
complete -c void-cli -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c void-cli -n "__fish_seen_subcommand_from create" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from create" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from add" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from add" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from add" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from get" -s s -l store -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from get" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from get" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from rm" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from rm" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from rm" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from ls" -s s -l store -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from ls" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from ls" -s l -d 'Prints sizes'
complete -c void-cli -n "__fish_seen_subcommand_from ls" -s H -d 'Prints human-readable sizes'
complete -c void-cli -n "__fish_seen_subcommand_from ls" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from metadata-set" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from metadata-set" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from metadata-set" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from metadata-get" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from metadata-get" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from metadata-get" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from metadata-list" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from metadata-list" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from metadata-list" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from metadata-remove" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from metadata-remove" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from metadata-remove" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from tag-add" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-add" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-add" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from tag-remove" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-remove" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-remove" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from tag-get" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-get" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-get" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from tag-clear" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-clear" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-clear" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from tag-list" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-list" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-list" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from tag-search" -s s -d 'Path to the store folder' -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-search" -s p -l password -r
complete -c void-cli -n "__fish_seen_subcommand_from tag-search" -s h -l help -d 'Print help information'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "create" -d 'Creates a new store'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "add" -d 'Adds a file or folder to the store'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "get" -d 'Get a file or folder from the store (unencrypts it)'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "rm" -d 'Removes a file or folder from the store'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "ls" -d 'List files in the store'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "metadata-set" -d 'Set file metadata'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "metadata-get" -d 'Get file metadata'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "metadata-list" -d 'List file metadata'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "metadata-remove" -d 'Remove file metadata'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "tag-add" -d 'Add node tag'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "tag-remove" -d 'Remove node tag'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "tag-get" -d 'Get node tags'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "tag-clear" -d 'Get node tags'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "tag-list" -d 'List tags in the filesystem'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "tag-search" -d 'List nodes with tags'
complete -c void-cli -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from add; and not __fish_seen_subcommand_from get; and not __fish_seen_subcommand_from rm; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from metadata-set; and not __fish_seen_subcommand_from metadata-get; and not __fish_seen_subcommand_from metadata-list; and not __fish_seen_subcommand_from metadata-remove; and not __fish_seen_subcommand_from tag-add; and not __fish_seen_subcommand_from tag-remove; and not __fish_seen_subcommand_from tag-get; and not __fish_seen_subcommand_from tag-clear; and not __fish_seen_subcommand_from tag-list; and not __fish_seen_subcommand_from tag-search; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'