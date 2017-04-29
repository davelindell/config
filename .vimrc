set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

let maplocalleader = "//"
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf/#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
set completeopt=longest,menu
let g:ycm_confirm_extra_conf=0
let g:ycm_server_use_vim_stdout=0
let g:ycm_server_keep_logfiles=1
let g:ycm_server_python_interpreter='/usr/bin/python2'

Plugin 'shougo/neoyank.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'lervag/vimtex'
call vundle#end()            " required
filetype plugin indent on    " required

" powerline
set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
let g:Powerline_symbols = 'fancy'
set noshowmode
set termencoding=utf-8
set encoding=utf-8
"let g:Powerline_dividers_override = ["\Ue0b0", "\Ue0b1", "\Ue0b2", "\Ue0b3"]
"let g:Powerline_symbols_override = { 'BRANCH': "\Ue0a0", 'LINE': "\Ue0a1", 'RO': "\Ue0a2" }

" vim-unite settings
nnoremap <C-P> :Unite -buffer-name=files file_rec/async:!<CR>
nnoremap <space>/ :Unite -no-empty -no-resize grep<CR>
nnoremap <space>s :Unite -quick-match buffer<CR>
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :Unite history/yank<CR>
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)

  nmap <silent><buffer><expr> Enter unite#do_action('switch')
  nmap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
  nmap <silent><buffer><expr> <C-h> unite#do_action('splitswitch')
  nmap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')

  imap <silent><buffer><expr> Enter unite#do_action('switch')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
  imap <silent><buffer><expr> <C-h> unite#do_action('splitswitch')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')

  map <buffer> <C-p> <Plug>(unite_toggle_auto_preview)

  nnoremap <ESC> :UniteClose<cr>
endfunction

call unite#custom#profile('default', 'context', {
\   'direction': 'botright',
\   'vertical_preview': 1,
\   'winheight': 15
\ })

" vim-gitgutter
set updatetime=250

" vim-colors-solarized
syntax enable
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

" Syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_matlab_checkers = ['mlint']
let g:syntastic_loc_list_height=5
" NERDTree settings


"window settings
set winheight=30
set winminheight=5

nmap <silent> <C-D> :NERDTreeToggle<CR>
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> > :exe "vertical resize " . (winwidth(0) * 5/4)<CR>
nnoremap <silent> < :exe "vertical resize " . (winwidth(0) * 4/5)<CR>

inoremap jk <esc>
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

filetype indent plugin on

" Use Function keys to switch between file buffers
:map <F6> :n<CR>
:map <F5> :prev<CR>
:map <F4> :e<CR>
:map <F8> :n<CR>G

"Always show current position
set ruler

" Set indenting rules
set cindent
set tabstop=4
set shiftwidth=4
set expandtab

"Turn line numbers on (turn off with set nu!)
set nu

"Set to auto read when file is changed from outside
set autoread

"matching bracket settings
set showmatch
set mat=2

" Set utf8 as standard encoding and en_US as the standard language
"set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile