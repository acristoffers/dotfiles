function fix-path-wrappers
    set -l NON_WRAPPERS
    set -l WRAPPERS
    for P in $PATH
        if string match -qe wrapper $P
            set -a WRAPPERS $P
        else
            set -a NON_WRAPPERS $P
        end
    end
    set -x PATH $WRAPPERS $NON_WRAPPERS
end
