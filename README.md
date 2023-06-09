# Configuration files
Brian Stewart


## Dotfiles
Install using GNU stow, like so:

`stow -d dotfiles/ -t ~ screen`


## Non-Dotfiles

### brew leaves
The command `brew leaves` produces a list of brew packages that were installed
as top-level items (not dependencies). The `brew-leaves` file is a snapshot of
Homebrew packages I've installed.

### iTerm2
`non-dotfiles/osx/iterm/` should contain one or more `.plist` files. Use the
iTerm2 GUI to adjust the preferences to read from (and optionally save to) this
directory.


## Submodules
To init a submodule:

`git submodule update --init --depth 1 non-dotfiles/osx/iterm_colors/`

To update a submodule to the current version:

`git submodule update --remote --merge`

(See: https://stackoverflow.com/questions/8191299/update-a-submodule)
