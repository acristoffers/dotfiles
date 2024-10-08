# Defined in /var/folders/7b/jjzx_8kj59s172r3j3g5yy400000gn/T//fish.W1etGc/update-doom.fish @ line 2
function update-doom
  title Updating Doom Emacs

  if not type -q emacs
    echo "emacs is not installed!"
    exit 1
  end

  if not type -q doom
    git clone --depth 1 https://github.com/doomemacs/doomemacs $XDG_CONFIG_HOME/emacs
    $XDG_CONFIG_HOME/emacs/bin/doom install
    touch $XDG_CONFIG_HOME/emacs/custom.el
    scfg
  end

  doom sync -u --gc -B -j 12 # update, garbage-collect, regraft if necessary, 12 threads aot
end
