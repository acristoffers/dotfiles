set -l fs (functions | grep ^update- | string replace update- '')
for f in $fs
  complete -c update -f -a $f
end

