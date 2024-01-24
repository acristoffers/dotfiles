function jp
  if test (count $argv) -gt 0
    set -l FZF_OPTS "--no-sort" "--keep-right" "--height=50%" "--info=inline" "--layout=reverse" "--exit-0" "--select-1" "--bind=ctrl-z:ignore" "--preview" "ls -Cp --group-directories-first {}" "--preview-window=down,30%"
    set -l result (zoxide query -l | grep -i $argv | fzf $FZF_OPTS)
    if test (count $result) -gt 0
      pushd $result
    end
  else
    set -l result (zoxide query -i)
    if test (count $result) -gt 0
      pushd $result
    end
  end
end
