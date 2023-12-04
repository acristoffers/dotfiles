function _git_fetch_on_cd --description 'Runs git fetch on cd' --on-variable PWD
    nohup timeout -k 2s 10s git fetch --all >/dev/null &>/dev/null &
end
