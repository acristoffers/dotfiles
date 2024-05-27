function ls --wraps=exa --description 'exa instead of ls'
  if isatty stdout && type -q eza
    eza --group-directories-first --git --icons $argv
  else
    command ls --color=auto $argv
  end
end
