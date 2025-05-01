function insert_last_command
  if not set -q __last_arg_index
    set -g __last_arg_index 1
  end

  if test (commandline) != "$__last_cmd_line"
    set -g __last_arg_index 1
  end

  set -l cmd (history --max 100 | egrep '^.+$' | cut -d' ' -f1 | uniq)
  set -l cmd $cmd[$__last_arg_index]
  if test -z "$cmd"
    return
  end

  set -l cl (commandline)
  if string match -r '\s$' -- $cl
    commandline --insert "$cmd"
  else
    set -l cmdline (string trim --right --chars ' ' -- $cl | string replace -r '\s*\S+$' '' )
    if test -z "$cmdline"
      commandline --replace $cmd
    else
      commandline --replace "$cmdline $cmd"
    end
  end

  set -g __last_arg_index (math $__last_arg_index + 1)
  set -g __last_cmd_line (commandline)
end
