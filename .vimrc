set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'easymotion/vim-easymotion'
Plugin 'flazz/vim-colorschemes'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neoyank.vim'
Plugin 'Shougo/unite.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'davidhalter/jedi-vim'
call vundle#end()            " required
filetype plugin indent on    " required

" indent guides
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_enable_on_vim_startup = 1

" spelling
set spelllang=en
"set spellfile=/home/lindell/.vim/words.add

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" powerline
set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2
let g:Powerline_symbols = 'fancy'
set noshowmode
set termencoding=utf-8
set encoding=utf-8

" jedi-vim
let g:jedi#show_call_signatures = "2"

" ycm
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
set completeopt=longest,menu
let g:ycm_confirm_extra_conf=0
let g:ycm_server_use_vim_stdout=0
let g:ycm_server_keep_logfiles=1
let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:ycm_use_ultisnips_completer = 1

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

  "map <buffer> <C-p> <Plug>(unite_toggle_auto_preview)
  "noremap <C-p> :Unite file-rec/async<cr>
  nnoremap <ESC> :UniteClose<cr>
endfunction

call unite#custom#profile('default', 'context', {
\   'direction': 'botright',
\   'vertical_preview': 1,
\   'winheight': 15
\ })

" ultisnips and snippets
let g:UltiSnipsSnippetsDir="/home/lindell/.vim/bundle/vim-snippets/UltiSnips"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsListSnips="<c-h>"
let g:UltiSnipsEditSplit="vertical"

" vim-gitgutter
set updatetime=250

" vim-colors-solarized
syntax enable
syntax on
set background=dark
colorscheme molokai

" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_matlab_checkers = ['mlint']
let g:syntastic_loc_list_height=5
nnoremap <silent> <C-u> :SyntasticToggleMode <CR>

" local leader
"let mapleader = ","
let maplocalleader = "\\"
let mapleader = '\'

"window settings
set winheight=30
set winminheight=5

nmap <silent> <C-D> :NERDTreeToggle<CR>
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> > :exe "vertical resize " . (winwidth(0) * 5/4)<CR>
nnoremap <silent> < :exe "vertical resize " . (winwidth(0) * 4/5)<CR>

inoremap jk <esc>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Use Function keys to switch between file buffers
":map <F6> :n<CR>
":map <F5> :prev<CR>
":map <F4> :e<CR>
":map <F8> :n<CR>G

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
set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
