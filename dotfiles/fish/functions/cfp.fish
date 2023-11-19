function cfp --argument file_name
    string trim "$(pwd)/$file_name" | pbcopy
end
