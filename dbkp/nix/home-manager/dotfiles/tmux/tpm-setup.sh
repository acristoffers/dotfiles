#!/usr/bin/env bash

export XDG_DATA_HOME=${XDG_DATA_HOME:=~/.local/share}

if [[ ! -d "$XDG_DATA_HOME/tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm "$XDG_DATA_HOME/tmux/plugins/tpm"
    "$XDG_DATA_HOME/tmux/plugins/tpm/bin/install_plugins"
fi

"$XDG_DATA_HOME/tmux/plugins/tpm/tpm"
