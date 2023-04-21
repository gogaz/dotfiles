" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

syntax on
set background=dark

" have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" have Vim load indentation rules and plugins according to the detected filetype
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
set bg=dark         " Enable support for dark background
set expandtab       " Replace tabs by spaces
set ts=4            " Replace tabs by 4 spaces
set sw=4            " Indent by 4 spaces
set nu              " Show line numbers
set mouse=a         " Mouse support
set laststatus=2    " Always show the status bar (0=never, 1=only if 2+ windows, 2=always)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

" Set per-filetype preferences
autocmd BufRead *.c set cindent tw=80
autocmd BufRead *.cxx set cindent
autocmd BufRead *.cpp set cindent
autocmd BufRead *.cc set cindent
autocmd BufRead *.h set cindent tw=80
autocmd BufRead *.hh set cindent
autocmd BufRead *.py set autoindent
autocmd BufRead *.pl set autoindent
autocmd BufRead *.sh set autoindent
autocmd BufRead *.rb set autoindent ts=2 sw=2
autocmd BufRead *.h set tw=80
autocmd BufRead *.c set tw=80

colorscheme dracula

" Hilight overlength
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%80v.\+/

" Colors for autocompletion
highlight Pmenu ctermbg=DarkGrey ctermfg=White
highlight PmenuSel ctermbg=DarkRed ctermfg=White

" plugin for auto-config per file (Makefile,...)
filetype plugin indent on

" PLUGINS
execute pathogen#infect()
"airline config
let g:airline_powerline_fonts=1
let g:airline_enable_fugitive=1
let g:airline_enable_syntastic=1
let g:airline_enable_bufferline=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols for airline
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" display open buffers in tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

