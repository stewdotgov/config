" .vimrc - A Vim configuration file
" Maintainer:   Brian Stewart <https://github.com/primordialstew>
" Version:      0.1

" ====================
" Vundle configuration
" ====================

" To manage plugins, I use the Vundle plugin. It requires the following
" configuration settings.

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'                  " Manage vim plugins
Plugin 'altercation/vim-colors-solarized'   " Eye-friendly colors
Plugin 'scrooloose/nerdtree'                " Fancy file tree explorer
Plugin 'hynek/vim-python-pep8-indent'       " PEP8-compliant autoindent
Plugin 'scrooloose/syntastic'               " Syntax checking
Plugin 'tpope/vim-repeat'                   " Make . work with plugin maps
Plugin 'tpope/vim-surround'                 " Easily edit parens, XML tags, etc
Plugin 'tpope/vim-fugitive'                 " Use git from within Vim 
Plugin 'tpope/vim-jdaddy'                   " JSON manipulation
Plugin 'tpope/vim-sensible'                 " Nice Vim settings (applied after
                                            " .vimrc by default)

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ


" =============================
" Plugin-specific configuration
" =============================

" --------
" NERDTree
" --------
let NERDTreeIgnore=['\.pyc$']   " don't show these files in NERDTree
" toggle NERDTree explorer
nnoremap <silent> <c-6> :NERDTreeToggle<CR>

" ---------
" Syntastic
" ---------
" recommended beginner settings for Syntastic,
" from https://github.com/scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" ============
" Vim settings
" ============

" -------------
" Compatibility
" -------------
set encoding=utf-8  " set default encoding to UTF8
set fileformat=unix " use \n line endings

" ------------------
" Indents & wrapping
" ------------------
set textwidth=79    " lines longer than 79 columns will be broken
"set textwidth=0     "Disable text wrapping
set expandtab       " insert spaces when hitting TABs
set autoindent      " align the new line indent with the previous line
"set smartindent     "Try to guess when indenting is needed
set tabstop=4       " a hard TAB displays as 4 columns
set softtabstop=4   " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftwidth=4    " operation >> indents 4 columns; << unindents 4 columns
set shiftround      " round indent to multiple of 'shiftwidth'

" ------------
" Code hygeine
" ------------
set number          " show line numbers
set colorcolumn=80  " highlight 80th column (vim 7.3+ only)
set showmatch       " briefly jump to matching parenthesis
syntax enable       " turn on syntax highlighting
" highlight floating whitespace in red
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /^\t\+/ " beginning tabs
match BadWhitespace /\s\+$/ " trailing whitespace

" ----------
" Aesthetics
" ----------
" set colorscheme. See $VIMRUNTIME/colors for the standard list.
"set guifont=Monospace\ 18
"set background=light
set background=dark
"colorscheme solarized
colorscheme desert


" ------------
" Command mode
" ------------
set history=300     " set a history of 300 commands

" -----
" Mouse
" -----
set ttymouse=xterm2

" -------------------
" Backup & swap files
" -------------------
" Files will be written to the first existing path in the list.
" The trailing // tells Vim to use filenames representing the absolute path
" of the edited file, to avoid name collisions.
set backupdir=~/tmp/vim//,~/tmp//,.     " write backup files here
set directory=~/tmp/vim//,~/tmp//,.     " write swapfiles here

" ====================
" Convenience mappings
" ====================

" -------------
" Function Keys
"nnoremap <F1> "toggle overlength highlighting
nnoremap <F2> :set number!<CR>
nnoremap <F3> :set invpaste paste?<CR>
nnoremap <F4> :call FoldArgumentsOntoMultipleLines()<CR>
nnoremap <F5> :call SyntasticToggleMode()<CR>
nnoremap <silent> <F6> :NERDTreeToggle<CR>
nnoremap <F7> :call ToggleBackground()<CR>
"nnoremap <F8>
"nnoremap <F9>
"nnoremap <F10>
nnoremap <F12> :call ToggleMouse()<CR>

inoremap <F4> <Esc>:call FoldArgumentsOntoMultipleLines()<CR>a

" ------
" Splits
" ------
" easier split (pane) navigation 
" use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR> 
nmap <silent> <c-j> :wincmd j<CR> 
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
"resize split windows
nnoremap = :exe "resize +2"<cr>
nnoremap - :exe "resize -2"<cr>

" -------
" Editing
" -------
" add a new line without insert mode
nnoremap <enter> o<esc>k
" toggle mouse
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Mouse usage disabled"
  else
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction
" toggle paste/nopaste
set pastetoggle=<F3>
set showmode
" The following maps F4 in normal and insert mode to doing a search and
" replace on the current line which converts all commas (with 0 or more
" spaces after each) into commas with a carriage return after each, then
" selects the whole group and indents it using the Vim builtin =.
" 
" A known shortcoming of this solution is for lines that include multiple
" template parameters (it breaks on their commas as well instead of just
" the commas of the normal parameters).
function FoldArgumentsOntoMultipleLines()
    substitute@,\s*@,\r@ge
    normal v``="
endfunction

" ---------
" Searching
" ---------
vnoremap // y/<C-R>"<CR>

" -----------
" Visual cues
" -----------
" toggle long line hightlighting
let g:overlength_enabled = 0
"highlight OverLength ctermbg=black guibg=#212121
highlight OverLength ctermbg=blue guibg=blue
function! ToggleOverLengthHighlight()
    if g:overlength_enabled == 0
        match OverLength /\%79v.*/
        let g:overlength_enabled = 1
        echo 'OverLength highlighting turned on'
    else
        match
        let g:overlength_enabled = 0
        echo 'OverLength highlighting turned off'
    endif
endfunction
nnoremap <leader>h :call ToggleOverLengthHighlight()<CR>
nnoremap <silent> <F1> :call ToggleOverLengthHighlight()<CR>
nnoremap <silent> <c-1> :call ToggleOverLengthHighlight()<CR>
" toggle line numbers
nnoremap <c-2> :set number!<CR>

" ----------
" Aesthetics
" ----------
function! ToggleBackground()
  if &background == 'light'
    set background=dark
    echo "Background set to dark"
  else
    set background=light
    echo "Background set to light"
  endif
endfunction

" -------------
" Special Cases
" -------------