# Configuration files
Brian Stewart


## Dotfiles
Install using GNU stow, e.g.

    stow -d dotfiles/ -t ~ screen


## Non-Dotfiles
Files in the `non-dotfiles` directory are not Posix-style dotfile configuration
files. Read on for instructions on how to apply them...

### iTerm2
`non-dotfiles/osx/iterm/` should contain one or more `.plist` files. Use the
iTerm2 GUI to adjust the preferences to read from (and optionally save to) this
directory.
