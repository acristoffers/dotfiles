function remove-path-duplicates
  set -x PATH (printf %s "$PATH" | awk -vRS=: '!a[$0]++')
end
