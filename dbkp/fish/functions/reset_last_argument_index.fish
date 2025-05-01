function reset_last_argument_index --on-event fish_preexec
  set -g __last_arg_index 1
end
