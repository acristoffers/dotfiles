function _tide_item_cwd
_tide_print_item cwd (basename (string replace -- $HOME '~' (pwd)))
end
