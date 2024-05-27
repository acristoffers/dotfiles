function add-to-path-if-exists
  eval "count $argv" >/dev/null || return
  eval "set -l fs $argv"
  for f in $fs
    if test -d $f; and not contains $f $PATH
      set -x PATH $f $PATH
    end
  end
end
