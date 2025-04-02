function gc
    git lfs prune
    git gc --aggressive --no-cruft --prune=now --keep-largest-pack
    git submodule foreach --recursive 'git gc --aggressive --prune=now'
end
