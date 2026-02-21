#!/usr/bin/env bash

set -euo pipefail

export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

if [[ ! -d "${XDG_DATA_HOME}/tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm "${XDG_DATA_HOME}/tmux/plugins/tpm"
    "${XDG_DATA_HOME}/tmux/plugins/tpm/bin/install_plugins"
fi

exec "${XDG_DATA_HOME}/tmux/plugins/tpm/tpm"
