                if status is-interactive
# abbr -a zellij --regex 'z[a|da|d|ka|k|ls|\-s]' -f zellij_abbr
abbr zj zellij
abbr d --set-cursor "cd % && ls"
abbr mkcd --set-cursor 'begin set -l dir % && mkdir -p $dir && cd $dir; end'
abbr hg "history|grep "
    # xsel
abbr xbi "xsel -bi"
abbr xbo "xsel -bo"
abbr xpi "xsel -pi"
abbr xpo "xsel -po"
abbr xsi "xsel -si"
abbr xso "xsel -so"
    set -x EDITOR "kakoune"
fish_add_path ~/.cargo/bin/
abbr kns kitten ssh
abbr fd fdfind
abbr kds "setsid kak -d -s"
abbr kc "kak -c"
abbr 'kc!' --set-cursor 'session_name=% setsid kak -d -s $session_name; kak -c $session_name'
abbr kl "kak -l"
alias kakln1c 'kak -c (kak -l | grep -xE "[[:digit:]]+" | head -n 1)'
alias kake 'setsid /var/lib/snapd/snap/bin/kakoune -d -s EDITOR 2>/dev/null ; /var/lib/snapd/snap/bin/kakoune -c EDITOR'
    fish_add_path ~/.local/bin ~/bin
fish_add_path ~/.cargo/bin/
# should I limit this to interactive session ?
eval (ssh-agent -c)

end

abbr cbi "cb -i"
abbr cbo "cb -o"


set LIBTORCH /usr/local/lib/libtorch/
set LD_LIBRARY_PATH {$LIBTORCH}lib:
set PKG_CONFIG_PATH /usr/lib64/pkgconfig/

