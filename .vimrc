" Martins .vimrc
" Please modify and redistribute

syntax on
set nu
set nowrap
set ignorecase
set smartcase
set incsearch
set showmatch
set matchtime=0
set bg=dark
set title
set mouse=c
set nomousefocus
set conceallevel=2
set viminfo=!,'20,<50,s10,h

if has('nvim')
    set undofile
    set backup
    set backupdir=~/.local/share/nvim/backup//
    set directory=~/.local/share/nvim/swap//
    set backupcopy=yes
else
    " Remove unwanted files
    set nobackup
    set noswapfile
end

" Forgot to run vim as sudo?
cmap w!! %!sudo tee > /dev/null %

if !empty($SUDO_USER) && $USER !=# $SUDO_USER
    set viminfo=
    set directory=/tmp//
    set backupdir=/tmp//
endif

" Fix capital O being tardy
set noesckeys
set timeoutlen=1000
set ttimeout
set ttimeoutlen=0

" Highlight newlines and tabs
set list
set listchars=tab:^\ ,nbsp:¶,eol:¬,extends:»,precedes:«
highlight NonText ctermfg=238
highlight SpecialKey ctermfg=24

" Spaces!
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

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
Plugin 'mattn/emmet-vim'
" Plugin 'Valloric/MatchTagAlways'
Plugin 'othree/html5.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'orourkek/vim-less'
Plugin 'ap/vim-css-color'
Plugin 'pangloss/vim-javascript'
Plugin 'vim-ruby/vim-ruby'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'M4R7iNP/smarty.vim'
Plugin 'M4R7iNP/vim-inky'
Plugin 'slim-template/vim-slim'
Plugin 'M4R7iNP/vim-nginx'
Plugin 'mxw/vim-jsx'
Plugin 'kshenoy/vim-signature'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'simeng/vim-imba'
Plugin 'jakobwesthoff/argumentrewrap'
Plugin 'derekwyatt/vim-scala'
Plugin 'godlygeek/tabular'
Plugin 'airblade/vim-gitgutter'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'majutsushi/tagbar'
Plugin 'benmills/vimux'
Plugin 'Shougo/neco-vim'
Plugin 'digitaltoad/vim-pug'
Plugin 'sbdchd/neoformat'

if has('python')
    Plugin 'editorconfig/editorconfig-vim'
endif

if has('nvim')
    Plugin 'benekastah/neomake'
    autocmd! BufWritePost * Neomake
    let g:neomake_javascript_enabled_makers = ['eslint']
    let g:neomake_jsx_enabled_makers = ['eslint']

    if has('python3')
        " Use deoplete
        Plugin 'Shougo/deoplete.nvim'
        let g:deoplete#enable_at_startup = 1
        let g:deoplete#tag#cache_limit_size = 5000000
        let g:deoplete#omni_patterns = {
            \ 'php': '\w+|[^. \t]->\w*|\w+::\w*'
        \ }
    endif
else
    Plugin 'scrooloose/syntastic'
    Plugin 'jaxbot/syntastic-react'
end

call vundle#end()
filetype plugin indent on

" plugin options
let g:mta_filetypes = { 'html' : 1, 'xhtml' : 1, 'xml' : 1, 'jinja' : 1, 'smarty': 1 }
let g:user_emmet_expandabbr_key = '<C-Z>'
let g:use_emmet_complete_tag = 1
let g:smarty_conceal_translated_strings = 1
let g:airline#extensions#tabline#enabled = 1
let g:javascript_enable_domhtmlcss = 1
let g:multi_cursor_quit_key = '<Tab>'

let g:user_emmet_settings = {
\  'html': {
\    'expandos': {
\      'table': 'table>(thead>tr>th)+(tbody>tr>td)'
\    }
\  },
\  'xml': {
\    'default_attributes' : {
\      'option': [{'name': ''}],
\      'rule': [{'match': ''}]
\    }
\  },
\  'php': {
\    'snippets': {
\      'aethermodule': "class ${cursor} extends AetherModule {\n\tfunction run() {\n\t\t\\$tpl = \\$this->sl->getTemplate();\n\t\t\\$config = \\$this->sl->get(\"aetherConfig\");\n\n\t}\r}",
\      'phphead': "<?php\n\n"
\    }
\  },
\  'smarty': {
\    'extends': 'html',
\    'snippets': {
\      'if': "{if |}\n{/if}",
\      'else': "{else}\n|",
\      'elseif': "{elseif |}",
\      'block': "{block name=\"|\"}\n{/block}",
\      'include': "{include '|'}",
\      'extends': "{extends '|'}",
\      'assign': "{assign |}",
\      'foreach': "{foreach |}\n{/foreach}"
\    }
\  }
\}

au BufNewFile *.php :Emmet phphead
au BufNewFile lib/modules/*.php :Emmet aethermodule
au Filetype xml setlocal makeprg=generateConfig\ %

" Spell
set spelllang=en,nb
set spellcapcheck=
hi SpellBad ctermbg=52
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

"### Remappings ###"

map <S-Left> <Left>
map <S-Right> <Right>
imap <S-Left> <Left>
imap <S-Right> <Right>

" Switch tabs using Ctrl left/right
nnoremap <C-L> gt
nnoremap <C-H> gT

" Disable annoying letters
nnoremap Q <nop>
nnoremap K <nop>
vnoremap K <nop>
nnoremap ; :

" Remap Esc to Tab
nnoremap <Tab> <Esc>
inoremap <Tab> <Esc>
vnoremap <Tab> <Esc>

nnoremap <F3> :set hls!<CR>
nnoremap <F4> :set nu!<CR>:set list!<CR>

" Leader mappings
map <silent> <leader>gs :Gstatus<cr>
map <silent> <leader>gd :Gdiff<cr>
map <leader>ge :Gedit<cr>
map <silent><leader>gr :Gread<cr>
map <silent><leader>gb :Gblame<cr>
map <leader>wt <C-w><S-t>
map <leader>t :spl<cr>:term<cr>
map <leader>l :set list!<cr>
" map <leader>v :tabe ~/.vimrc<cr>
map <leader>reload :source ~/.vimrc<cr>
nnoremap <silent> <leader>A :call argumentrewrap#RewrapArguments()<CR>
map <leader>e :e <C-R>=expand("%:h") . "/" <CR>
map <leader>t :tabe <C-R>=expand("%:h") . "/" <CR>
map <leader>s :split <C-R>=expand("%:h") . "/" <CR>
map <leader>v :vsp <C-R>=expand("%:h") . "/" <CR>
noremap <leader>f :Neoformat<CR>

autocmd BufWinEnter /etc/nginx/*.conf setfiletype nginx
autocmd BufWinEnter ~/nginx-config/sites-*/* setfiletype nginx
autocmd BufWinEnter /etc/varnish/*.vcl setfiletype conf
autocmd FileType gitcommit,html,smarty,eruby,slim,po setlocal spell
autocmd BufWinEnter /etc/cron.d/* set noexpandtab
autocmd BufWinEnter .eslintrc set ft=json

" Nvim's terminal w00t
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <Tab> <C-\><C-n>
    tnoremap <S-Tab> <Tab>
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>l <C-\><C-n><C-w>l
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k

    autocmd TermOpen * setlocal nolist
endif

" Improved tab completion (:tabe awd<tab>)
set wildmode=longest,list,full
set wildmenu

" For tmux
set lazyredraw

" Hwo 2 witre plz
cnoreabbrev tbae tabe
cnoreabbrev vps vsp
inoreabbrev requrie require
inoreabbrev esacpe escape
digraph ./ 8230

" Nicer window scrolling
set scrolloff=4
set sidescrolloff=15
set sidescroll=1

" I dont recall what this does
set formatoptions& formatoptions+=mM

" Don't highlight tabs in projects that use tabs as indentation
if exists("g:loaded_EditorConfig")
    function g:SetListChars(config)
        if has_key(a:config, "indent_style")
            if a:config["indent_style"] == "tab"
                set listchars=tab:\ \ ,nbsp:¶,eol:¬
            endif
        endif

        return 0
    endfunction

    call editorconfig#AddNewHook(function('g:SetListChars'))
endif

" Improve go-to-definition and omnicompletion behavior
nnoremap g] <C-w><C-]><C-w>T
set completeopt=longest,menuone

" I have local .vimrc in ~/.local/.vimrc
if filereadable(expand("$HOME") . "/.local/.vimrc")
    source $HOME/.local/.vimrc
endif
