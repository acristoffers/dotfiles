function vardedup --description 'Remove duplicates from environment variable'
  if test (count $argv) = 1
    set -l newvar
    for v in $$argv
      if not contains -- $v $newvar
        set newvar $newvar $v
      end
    end
    set -x $argv $newvar
  else
    for a in $argv
      vardedup $a
    end
  end
end
