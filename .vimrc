" Martins .vimrc
" Please modify and redistribute

syntax on
set nu
set nowrap
set ignorecase
set smartcase
set incsearch
set showmatch
set bg=dark
set title

" Remove unwanted files
set nobackup
set noswapfile

" Forgot to run vim as sudo?
cmap w!! %!sudo tee > /dev/null %

" Fix captial O being tardy
set noesckeys
set timeoutlen=100
set ttimeout
set ttimeoutlen=0

" Highlight unwanted spaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Highlight newlines and tabs
set list
set listchars=tab:^\ ,nbsp:¶,eol:¬
" set listchars=nbsp:¶,eol:ᒣ

" Spaces!
set tabstop=4
set shiftwidth=4
set expandtab

" Plugin specific settings
set nocompatible
filetype off
set t_Co=256
set laststatus=2

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'bling/vim-airline'
" Plugin 'Shutnik/jshint2.vim'
Plugin 'mattn/emmet-vim'
" Plugin 'Valloric/MatchTagAlways'
Plugin 'othree/html5.vim'
Plugin 'tpope/vim-unimpaired'
" Plugin 'groenewege/vim-less'
Plugin 'orourkek/vim-less'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'blueyed/smarty.vim'
Plugin 'nginx.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jaxbot/syntastic-react'
Plugin 'mxw/vim-jsx'

call vundle#end()
filetype plugin indent on

" let jshint2_read = 1
let g:mta_filetypes = { 'html' : 1, 'xhtml' : 1, 'xml' : 1, 'jinja' : 1, 'smarty': 1 }
let g:user_emmet_expandabbr_key = '<C-Z>'
let g:use_emmet_complete_tag = 1
let g:airline#extensions#tabline#enabled = 1
let g:javascript_enable_domhtmlcss = 1
let g:syntastic_javascript_checkers = ['eslint']

"### Remappings ###"

map <S-Left> <Left>
map <S-Right> <Right>
imap <S-Left> <Left>
imap <S-Right> <Right>

" Switch tabs using Ctrl left/right
nnoremap <C-L> gt<CR>
nnoremap <C-H> gT<CR>

nnoremap Q <nop>
nnoremap K <nop>
nnoremap ; :

" Remap Esc to Tab
nnoremap <Tab> <Esc>
inoremap <Tab> <Esc>
vnoremap <Tab> <Esc>

nnoremap <F3> :set hls!<CR>
nnoremap <F4> :set nu!<CR>:set list!<CR>
nnoremap <F5> :!php -l %<CR>
" nnoremap <F6> :JSHint<CR>
nnoremap <F7> mzgg=G`z<CR>

set matchtime=0

autocmd BufWinEnter /etc/nginx/*.conf setfiletype nginx

" Nvim's terminal w00t
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>l <C-\><C-n><C-w>l
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k

    autocmd TermOpen * set nolist
endif

" Improved tab completion (:tabe awd<tab>)
set wildmode=longest,list,full
set wildmenu

" For tmux
set lazyredraw

" Lews
autocmd BufWritePost ~/static.tek.no/*.less silent !echo -ne '<afile>:p' | nc -U ~/static.tek.no/lews.sock

" Hwo 2 witre plz
cnoreabbrev tbae tabe
inoreabbrev requrie require

" Nicer window scrolling
set scrolloff=4
set sidescrolloff=15
set sidescroll=1

" I dont recall what this does
set formatoptions& formatoptions+=mM

" Dont hightlight tabs in projects that use tabs as indentation
function! s:SetListChars(config)
    if has_key(a:config, "indent_style")
        if a:config["indent_style"] == "tab"
            set listchars=tab:\ \ ,nbsp:¶,eol:¬
        endif
    endif
endfunction
call editorconfig#AddNewHook(function('s:SetListChars'))
