function rr --argument from to where
    if test -f $where
        awk -i inplace -v FROM=$from -v TO=$to '/FROM/gsub(FROM,TO,$0)' $where
    else
        pushd $where
        rg -l $from | xargs -n 1 awk -i inplace -v FROM=$from -v TO=$to '/FROM/gsub(FROM,TO,$0)'
        popd
    end
end
