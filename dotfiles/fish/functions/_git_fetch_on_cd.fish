function _git_fetch_on_cd --description 'Runs git fetch on cd' --on-variable PWD
    nohup git fetch --all >/dev/null &>/dev/null &
end
