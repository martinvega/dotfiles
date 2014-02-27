set nocompatible

runtime bundle/vim-pathogen/autoload/pathogen.vim

call pathogen#infect()
call pathogen#helptags()

if has('syntax')
  syntax on
endif

if has('autocmd')
  filetype plugin indent on
  augroup vimrcEx
    autocmd!
    " Remember last position in file
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
  augroup END
endif

if has('multi_byte')
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
  set nobomb
endif

if has('mouse')
  set mouse=nv
endif

if has('spell')
  set spell
  set spelllang=en_us
  nnoremap _s :set spell!<CR>
endif

if !exists('g:fugitive_git_executable')
  let g:fugitive_git_executable='LC_ALL=en_US git'
endif

" Tab behavior
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set shiftround

set hlsearch
set incsearch

set cursorline

" Maintain undo history between sessions
if exists('+undofile') && exists('+undodir')
  set undofile
  set undodir=~/.vim/undodir
endif

" Read changes on disk
set autoread
