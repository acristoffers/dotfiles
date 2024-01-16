function sr --argument whit what
    rg -l $whit | xargs sed -i "s/$whit/$what/g"
end
