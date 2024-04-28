#!/usr/bin/env fish

for file in (fd -H ^clean.sh\$)
  pushd (dirname $file)
  zsh clean.sh
  popd
end

for file in (fd -H ^clean.fish\$)
  pushd (dirname $file)
  fish clean.fish
  popd
end

for file in (fd -H ^settings.gradle)
  set parent (dirname $file)
  while test $parent != .
    if test -e $parent/pubspec.yaml
      set parent =
      break
    end
    set parent (dirname $parent)
  end
  if test $parent = .
    pushd (dirname $file)
    gradle clean
    popd
  end
end

for file in (fd -H ^pubspec.yaml\$)
  pushd (dirname $file)
  flutter clean
  popd
end

for file in (fd -H ^cargo.toml\$)
  pushd (dirname $file)
  cargo clean
  popd
end

for file in (fd -H ^Makefile\$)
  pushd (dirname $file)
  if grep -q "^clean:" Makefile
    make clean &> /dev/null
  end
  popd
end

for file in (fd -H ^setup.py\$)
  pushd (dirname $file)
  python3 setup.py clean
  popd
end

set trash_files build .gradle out dist .idea .DS_Store Thumbs.db .sass-cache \
                __pycache__ zig-cache zig-out node_modules log logs .log .logs target
fd -HI0 (string join \| ^$trash_files\$) . | xargs -0n 1 rm -rf

