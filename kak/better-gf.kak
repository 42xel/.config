## better gf
# TODO echo info
# TODO auto select next valid file in selection, line, or from selection start.
# Probably for F, only select and stay in goto mode.
# TODO Gf combines both, GF extends multi selection
# TODO : use %val{register} if provided
map -docstring "file[:line[:column]]" global goto f "<esc>: goto-file<ret>"
define-command -docstring "go to the file corresponding to the current selection" goto-file %{
  # TODO add something to the effect of -itersel
  evaluate-commands edit -existing %sh{ echo "$kak_selection" | sed 's/:/ /g' }
}
alias global gf goto-file

# TODO use @val{count} if provided
define-command -docstring "go to the next filename candidate" -hidden goto-filename-regex %{
  evaluate-commands -draft %{
    try %{
      edit -existing *gf*
    } catch %{
      edit -scratch *gf*
      # turning the result of ls into a regex
      execute-keys '! ls -aF<ret><a-s>i|\Q<a-;><a-;>\E<del><esc>'
      # inserting absolute paths (root and home)
      execute-keys ',I((?<lt>=\s)~?/[\w\.]<esc>'
      # allowing suffixe
      execute-keys 'A)[^\s]*<esc>'
    }
    execute-keys -save-regs '' 'ggx_"/y'
  }
}

define-command -docstring "go to the next filename candidate" -hidden goto-filename %{
  evaluate-commands -save-regs '/' %{
    goto-filename-regex
    execute-keys '/<ret>'
  }
}
alias global gF goto-filename

define-command -docstring "go to the previous filename candidate. Unstable, might get replaced by count goto-filename" -hidden goto-filename-back %{
  evaluate-commands -save-regs '/' %{
    goto-filename-regex
    execute-keys '<a-/><ret>'
  }
}

map -docstring "goto filename" global goto F "<esc>: goto-filename<ret>g"
map -docstring "goto filename" global goto <a-F> "<esc>: goto-filename-back<ret>g"
