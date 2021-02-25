# maps caps lock to the escape key AND left control key (for Neovim and because it's so sweet).
# setxkbmap -option 'caps:ctrl_modifier';xcape -e 'Caps_Lock=Escape'&
# setxkbmap -model thinkpad -layout us -variant dvorak -option caps:ctrl_nocaps;xcape -e 'Caps_Lock=Escape'&
setxkbmap -model thinkpad -layout us -variant dvorak -option 'ctrl:nocaps'
xcape -e 'Control_L=Escape'
