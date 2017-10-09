# Configuration files
Brian Stewart


## Dotfiles
Install using GNU stow, e.g.

    stow -d dotfiles/ -t ~ screen


## Non-Dotfiles

### brew leaves
The command `brew leaves` produces a list of brew packages that were installed
as top-level items (not dependencies). The `brew-leaves` file is a snapshot of
Homebrew packages I've installed.

### iTerm2
`non-dotfiles/osx/iterm/` should contain one or more `.plist` files. Use the
iTerm2 GUI to adjust the preferences to read from (and optionally save to) this
directory.
