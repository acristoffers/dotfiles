function __fzf_path
    set token (commandline -ct)
    set filter (string replace -r "\*\*\$" "" $token)
    set result (fd -t directory --strip-cwd-prefix | fzf --query $filter)
    if test -n "$result"
        commandline -t "$result"
    end
end
