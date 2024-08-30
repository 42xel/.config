# Interstingly, braces are parsed before comments, with unintended consequences
# IDEA : \K in <a-k> should regex modify the selection. That's kind of what s does except not really.

eval %sh{ kak-tree-sitter -dksvv --init $kak_session --with-text-objects }

set-option global ui_options terminal_assistant=cat
# colorscheme red-phoenix

add-highlighter global/ number-lines -hlcursor -min-digits 3
add-highlighter global/ show-matching
# add-highlighter global/wrap wrap

add-highlighter global/show-whitespaces show-whitespaces -spc " "
set-option global tabstop 4
# kak
hook global WinSetOption filetype=kak %{
  # set-option window makecmd "source...?"
  set-option window tabstop 2
  set-option window indentwidth %opt{tabstop}
}

set-option global scrolloff 3,8

# yanking into clipboard (requires xsel install, and X11 forwarding)
map global normal <c-y> "<a-|> xsel -ib<ret>"
map global normal <c-p> "!xsel -bo<ret>"
map global normal <c-v> "<a-!>xsel -bo<ret>"
map global insert <c-y> "<a-;><a-|> xsel -ib<ret>"
map global insert <ins> <c-v>
map global insert <c-v> "<a-;><a-!> xsel -bo<ret>"

# comment line
# TODO use a different shortcut in qwerty
map global normal <a-q> ": comment-line<ret>"
map global insert <a-q> "<a-;>: comment-line<ret>"

# map global normal f ':on-key %{execute-keys "f%val{key};"}<ret>'
map global normal f ':f-desel<ret>'
define-command -hidden f-desel %{
  execute-keys 'f'
  on-key %{execute-keys "%val{key};"}
}
map global normal <a-f> ':a-f-desel<ret>'
define-command -hidden a-f-desel %{
  execute-keys '<a-f>'
  on-key %{execute-keys "%val{key};"}
}

# # plugging in the plugin manager
# source "%val{config}/plugins/plug.kak/rc/plug.kak"
# plug "andreyorst/plug.kak" noload
evaluate-commands %sh{
    plugins="$kak_config/plugins"
    mkdir -p "$plugins"
    [ ! -e "$plugins/plug.kak" ] && \
        git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
    printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
}
plug "andreyorst/plug.kak" noload

# ## TODO test and make better
# # autopairs
# plug "alexherbo2/auto-pairs.kak" config %{
#   enable-auto-pairs
# }
# pairs
plug "42xel/pairs.kak" config %{
  pairs_enable
}

## TODO: learn to use
# fzf
plug "andreyorst/fzf.kak" config %{
  require-module fzf
  require-module fzf-grep
  require-module fzf-file
} defer fzf %{
  set-option global fzf_highlight_command "lat -r {}"
} defer fzf-file %{
  set-option global fzf_file_command "fdfind . --no-ignore-vcs"
} defer fzf-grep %{
  set-option global fzf_grep_command "fdfind"
}
map -docstring "fzf" global user z ": fzf-mode<ret>"

## TODO see if still useful after fzf and harpoon/pokemon
define-command -docstring "fd [<arguments>]: scratch fdfind" -params .. fdfind %{
  edit -scratch *fd*
  execute-keys "gg! fdfind %arg{@}<ret><a-o>"
}
alias global fd fdfind

plug "andreyorst/powerline.kak" defer kakoune-themes %{
  powerline-theme pastel
} defer powerline %{
  powerline-format global "git lsp bufname filetype mode_info lsp line_column position session"
  set-option global powerline_separator_thin ""
  set-option global powerline_separator ""
} config %{
  powerline-start
}

plug "gustavo-hms/luar" %{
  require-module luar
}

plug "kak-lsp/kak-lsp" do %{
  cargo install --locked --force --path .
  # optional: if you want to use specific language servers
  mkdir -p ~/.config/kak-lsp
  cp -n kak-lsp.toml ~/.config/kak-lsp/
}
set-option global lsp_auto_highlight_references true
map -docstring "lsp mode" global user l ": enter-user-mode lsp<ret>"
# map -docstring "open lsp" normal user <square> ": enter-user-mode lsp<ret>"
map -docstring "goto next mistake" global normal <F8> ": lsp-find-error --include-warnings<ret>: lsp-hover<ret>"
map -docstring "lsp hover" global normal <F1> ": lsp-hover<ret>"
# TODO : use %val{register} if provided and free <s-F2>
map -docstring "rename" global normal <F2> ": lsp-rename-prompt<ret>"
map -docstring "rename" global normal <s-F2> ": lsp-rename %%reg{dquote}<ret>"
map -docstring "open lsp" global normal <F3> ": enter-user-mode lsp<ret>a<ret>"
# TODO previous error and insert.
map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
map global object * '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
# map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object F '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object S '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
map global goto w '<esc><a-i><a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
map global goto W '<esc><a-i><a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'
# TODO use these technique to select filename ?
# TODO look for a kak-snippet

# rust
hook global WinSetOption filetype=rust %{
  lsp-enable-window
  # doesn't work, wrong argument count. see ~/.config/kak/plugins/kak-lsp/rc/lsp.kak:2209:5
  # lsp-inlay-diagnostics-enable "global"

  set-option window makecmd "cargo build --release 2>&1"
  define-command -override -params .. -docstring \
  "build [<arguments>]: cargo build wrapper utility. All arguments are forwarded to the cargo build command."\
  build %{
    set-option window makecmd "cargo build"
    make %arg{@}
  }
  define-command -override -params .. -docstring \
  "test [<arguments>]: cargo test wrapper utility. All arguments are forwarded to the cargo test command."\
  test %{
    set-option window makecmd "cargo test"
    make %arg{@}
  }

  hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
  hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
  hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
  hook -once -always window WinSetOption filetype=.* %{
    remove-hooks window semantic-tokens
  }
}

# perl
hook global WinSetOption filetype=perl %{
  set-option buffer tabstop 3
  set-option window indentwidth %opt{tabstop}
  pairs_map  /   /  ; pairs_map-alias  /   /  l
}

# C
hook global WinSetOption filetype=c %{
  set-option buffer tabstop 3
  set-option window indentwidth %opt{tabstop}
}

# java
hook global WinSetOption filetype=java %{
  lsp-enable-window

  hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
  hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
  hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
  hook -once -always window WinSetOption filetype=.* %{
    remove-hooks window semantic-tokens
  }
}

# # auto save on exit insert mode
# hook global ModeChange pop:insert:.* %{
#   try %{
#     write
#     echo "file saved at %sh{date}"
#   }
# }

source ~/.config/kak/arrow_keys.kak
source ~/.config/kak/better-gf.kak

define-command -params .. -docstring \
"tree [<arguments>]: execute tree into a buffer, with the following options :
- -f to have full pathnames.
- --charset to have indentation using plain space characters instead of fancy character art.
- -F to know file type even without color.
- whatever arguments provided." \
tree %{
  try %{
     delete-buffer *tree*
  }
  edit -scratch *tree*
  execute-keys "! tree -fF --charset ASCII %arg{@}<ret>%%s^[\h|\-`]+<ret>r<space>gg"
}



