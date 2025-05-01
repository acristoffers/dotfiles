function __fzf_file
    set token (commandline -ct)
    set filter (string replace -r "\*\*\$" "" $token)
    set result (fd -t file --strip-cwd-prefix | fzf --query $filter)
    if test -n "$result"
        commandline -t "$result"
    end
end
