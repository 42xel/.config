# TODO make it so the echo messages are properly displayed.
declare-user-mode file
# TODO : appended arguments (w!, q!, wa ...)
map -docstring "write" global file 'w' "<esc>: write<ret>"
map -docstring "write-all" global file 'W' "<esc>: write-all<ret>"
map -docstring "quit" global file 'q' "<esc>: quit<ret>"

map -docstring "delete-buffer" global file 'd' "<esc>: delete-buffer<ret>"
# TODO lsp-format ?

map -docstring "kill" global file 'K' "<esc>: kill<ret>"
map -docstring "edit" global file 'e' "<esc>: edit -scratch "

# TODO : buffer navigation
