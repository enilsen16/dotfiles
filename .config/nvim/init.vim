scriptencoding utf-8

" Settings
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set formatoptions=tcrq
set wrap
set nolist
set textwidth=100
set updatetime=100
let g:mapleader=' '
let g:maplocalleader='\\'
set mouse=""
set hlsearch
set incsearch
set ignorecase smartcase
set smartcase
set number
set title

""" Undo #undo
" undofile - This allows you to use undos after exiting and restarting
" This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
set undodir=./.vim-undo//
set undodir+=~/.vim/undo//
set undofile

" Plugins
call plug#begin()

Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-rooter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
Plug 'Shougo/neco-syntax'
Plug 'editorconfig/editorconfig-vim'
Plug 'jakwings/vim-pony'
Plug 'sheerun/vim-polyglot'
Plug 'iCyMind/NeoSolarized'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme = 'solarized'
  let g:bufferline_echo = 0
  let g:airline_powerline_fonts=0
  let g:airline_enable_branch=1
  let g:airline_enable_syntastic=1
  let g:airline_branch_prefix = '⎇ '
  let g:airline_paste_symbol = '∥'
  let g:airline#extensions#tabline#enabled = 0
Plug 'benmills/vimux'
Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_cache_dir = '~/.tags_cache'
Plug 'bogado/file-line'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim', {'for': ['elixir', 'erlang']}
  let g:alchemist_iex_term_split = 'split'
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist'
Plug 'dietsche/vim-lastplace'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-speeddating'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  let g:fzf_buffers_jump = 1

call plug#end()

" UI
set termguicolors
syntax enable
set background=dark
colorscheme NeoSolarized

set t_8f=^[[38;2;%lu;%lu;%lum
set t_8b=^[[48;2;%lu;%lu;%lum

" Filetypes
augroup erlang
  autocmd!
  autocmd BufNewFile,BufRead *.erl setlocal tabstop=4
  autocmd BufNewFile,BufRead *.erl setlocal shiftwidth=4
  autocmd BufNewFile,BufRead *.erl setlocal softtabstop=4
  autocmd BufNewFile,BufRead relx.config setlocal filetype=erlang
augroup END

" Normalization
func! DeleteTrailingWS()
  exe 'normal mz'
  %s/\s\+$//ge
  exe 'normal `z'
endfunc

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

augroup whitespace
  autocmd BufWrite * silent call DeleteTrailingWS()
augroup END

" Navigation
" Navigate terminal with C-h,j,k,l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
