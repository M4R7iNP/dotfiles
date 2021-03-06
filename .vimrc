" Martins .vimrc
" Please modify and redistribute

" General options {{{
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
set noshowmode
set autoindent
set copyindent
set splitbelow
set splitright
set undolevels=1000
set undoreload=10000
if exists('&signcolumn')
    set signcolumn=yes
endif

if has('nvim')
    set undofile
    set backup
    set backupdir=~/.local/share/nvim/backup//
    set directory=~/.local/share/nvim/swap//
    set undodir=~/.local/share/nvim/undo//
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
if !has('nvim-0.2')
    set noesckeys
end
set timeoutlen=1000
set ttimeout
set ttimeoutlen=0

" Highlight newlines and tabs
set list
set listchars=tab:^\ ,nbsp:¶,eol:¬,extends:»,precedes:«
highlight NonText ctermfg=238
highlight SpecialKey ctermfg=24
highlight NeomakeWarningDefault ctermfg=232 ctermbg=214 guifg=#000000 guibg=#ffaf00

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
" }}}

" Plugins {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-speeddating'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'bling/vim-airline'
Plugin 'mattn/emmet-vim'
Plugin 'ap/vim-css-color'
Plugin 'vim-ruby/vim-ruby'
Plugin 'kshenoy/vim-signature'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'jakobwesthoff/argumentrewrap'
Plugin 'godlygeek/tabular'
Plugin 'airblade/vim-gitgutter'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'majutsushi/tagbar'
Plugin 'benmills/vimux'
Plugin 'sbdchd/neoformat' " runs e.g. prettier
Plugin 'ctrlpvim/ctrlp.vim' " ctrlp search
Plugin 'w0rp/ale' " lint
Plugin 'sjl/gundo.vim'
Plugin 'elixir-editors/vim-elixir'

" language specific plugins
Plugin 'othree/html5.vim'
" Plugin 'orourkek/vim-less'
" Plugin 'groenewege/vim-less'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" Plugin 'leafgarland/typescript-vim'
Plugin 'M4R7iNP/yats.vim'
Plugin 'mhartington/nvim-typescript'
" Plugin 'peitalin/vim-jsx-typescript'
Plugin 'simeng/vim-imba'
Plugin 'M4R7iNP/smarty.vim'
Plugin 'M4R7iNP/vim-inky'
Plugin 'M4R7iNP/vim-nginx'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'digitaltoad/vim-pug'
Plugin 'Shougo/neco-vim'
Plugin 'Shougo/neco-syntax'
Plugin 'jparise/vim-graphql'
Plugin 'derekwyatt/vim-scala'
Plugin 'slim-template/vim-slim'
Plugin 'wokalski/autocomplete-flow'
Plugin 'fgsch/vim-varnish'
Plugin 'jwalton512/vim-blade'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'GutenYe/json5.vim'

if has('python') || has('python3')
    Plugin 'editorconfig/editorconfig-vim'
endif

if has('nvim') || v:version >= 800
    Plugin 'ludovicchabant/vim-gutentags'
end

if has('nvim')
    " Plugin 'benekastah/neomake'
    " autocmd! BufWritePost * Neomake
    " let g:neomake_javascript_enabled_makers = ['eslint']
    " let g:neomake_jsx_enabled_makers = ['eslint']

    if has('python3')
        " Use deoplete
        Plugin 'Shougo/deoplete.nvim'
        let g:deoplete#enable_at_startup = 1
        " let g:deoplete#auto_complete_start_length = 1
        " let g:deoplete#enable_smart_case = 1
        let g:deoplete#tag#cache_limit_size = 5000000
        let g:deoplete#omni_patterns = {
            \ 'javascript': '[^. *\t]\.\w*',
            \ 'php': '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?',
        \ }
        let g:echodoc#enable_at_startup = 1
        let g:echodoc#type = 'virtual'

        Plugin 'Shougo/echodoc.vim'
        Plugin 'Shougo/denite.nvim'
    endif
else
    Plugin 'scrooloose/syntastic'
    Plugin 'jaxbot/syntastic-react'
end

call vundle#end()
filetype plugin indent on

"}}}

" Plugin options {{{
let g:mta_filetypes = { 'html' : 1, 'xhtml' : 1, 'xml' : 1, 'jinja' : 1, 'smarty': 1 }
let g:user_emmet_expandabbr_key = '<C-Z>'
let g:user_emmet_complete_tag = 1
let g:smarty_conceal_translated_strings = 1
let g:airline#extensions#tabline#enabled = 1
let g:javascript_enable_domhtmlcss = 1
let g:javascript_plugin_flow = 1
let g:multi_cursor_quit_key = '<Tab>'
let g:neoformat_try_formatprg = 1
let g:neoformat_enabled_scss = ['prettier']
let g:neoformat_enabled_typescriptreact = ['prettier']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" let g:ale_linters_ignore = {'typescript': ['tslint', 'tsserver'], 'javascript': ['tslint', 'tsserver']}
" let g:yats_host_keyword = 0
let php_sql_query = 1
let g:sql_type_default = 'postgresql'
let php_folding = 1
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags', '--options=' . $HOME . '/dotfiles/.ctags']
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'
highlight link EchoDocFloat Pmenu
let g:deoplete#enable_at_startup = 1
if exists("*deoplete#custom#option")
    call deoplete#custom#option({
        \ 'smart_case': v:true,
        \ 'omni_patterns': {
            \ 'javascript': '[^. *\t]\.\w*',
            \ 'php': '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?',
        \ }
    \ })
endif
" }}}

" Emmet options {{{
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
\    'extends': 'html',
\    'snippets': {
\      'aethermodule': "class ${cursor} extends AetherModule {\n\tfunction run() {\n\t\t\\$tpl = \\$this->sl->getTemplate();\n\t\t\\$config = \\$this->sl->get(\"aetherConfig\");\n\n\t}\r}",
\      'phphead': "<?php\n"
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

"}}}

" Autocmds {{{
au BufWinEnter /etc/nginx/*.conf setfiletype nginx
au BufWinEnter ~/nginx-config/sites-*/* setfiletype nginx
au BufWinEnter /etc/varnish/*.vcl setfiletype conf
au FileType gitcommit,html,smarty,eruby,slim,po setlocal spell
au BufWinEnter /etc/cron.d/* set noexpandtab
au BufWinEnter .eslintrc set ft=json
au BufNewFile,BufRead *.prisma set ft=graphql
au BufNewFile,BufRead *.vcl set cindent
au BufNewFile *.php :Emmet phphead
au BufNewFile lib/modules/*.php :Emmet aethermodule
au BufNewFile * nested call OpenClosestJsFile()
au Filetype xml setlocal makeprg=generateConfig\ %
au FileType vim set foldmethod=marker
" au FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
au FileType php setlocal omnifunc=phpcomplete#CompletePHP
au Filetype javascript.jsx call EnableGraphqlSyntaxHighlighting()
au Filetype javascript call EnableSqlSyntaxHighlighting()
au FileType javascript setlocal foldmethod=syntax
au FileType typescript setlocal foldmethod=syntax
au Filetype javascript.jsx nested call OpenCssModule()
au FileType yaml set sw=2
"}}}

" Functions {{{
function! OpenClosestJsFile()
    let l:paths=[
    \   expand('%') . '.js',
    \   expand('%') . 'js',
    \   expand('%') . '.jsx',
    \   expand('%') . 'jsx',
    \   expand('%') . '.ts',
    \   expand('%') . 'ts',
    \   expand('%') . 'tsx',
    \   expand('%') . '.tsx' ]
    for l:path in l:paths
        if filereadable(l:path)
            execute 'edit' fnameescape(l:path)
        endif
    endfor
endfunction

function! OpenCssModule()
    let l:css_module_path = substitute(expand('%'), '\.js$', '.module.css', '')
    if l:css_module_path == expand('%')
        return
    endif

    if filereadable(l:css_module_path)
        execute 'vsplit' l:css_module_path
        wincmd w
    endif
endfunction

function! EnableGraphqlSyntaxHighlighting()
    if exists('b:current_syntax')
        unlet b:current_syntax
    endif

    syn include @javascriptGraphql syntax/graphql.vim

    if exists('s:current_syntax')
        let b:current_syntax=s:current_syntax
    else
        unlet b:current_syntax
    endif

    syn region jsGraphql start=+`+ skip=+\\\(`\|$\)+ end=+`+ keepend contains=jsTemplateExpressionGraphql,@javascriptGraphql
    syn region jsTemplateExpressionGraphql contained containedin=@javascriptGraphql matchgroup=jsTemplateBraces start=+${+ end=+}+ contains=@jsExpression keepend
    syn match jsGraphqlStart contained /\(Relay\.QL\|graphql\|gql\)\%(`\)\@=/ nextgroup=jsGraphql
    syn cluster jsExpression add=jsGraphqlStart

    " hi link jsGraphql String
    hi link jsGraphqlStart StorageClass
endfunction

function! EnableSqlSyntaxHighlighting()
    if exists('b:current_syntax')
        unlet b:current_syntax
    endif

    syn include @SQL syntax/sql.vim
    syn sync clear
    syn cluster SQL remove=sqlString,sqlComment

    if exists('s:current_syntax')
        let b:current_syntax=s:current_syntax
    else
        unlet b:current_syntax
    endif

    syn region SQLEmbedded start=+\z(['"`]\)\zs\_s*\v(ALTER|CALL|COMMENT|COMMIT|CONNECT|CREATE|DELETE|DROP|EXPLAIN|EXPORT|GRANT|IMPORT|INSERT|LOAD|LOCK|MERGE|REFRESH|RENAME|REPLACE|REVOKE|ROLLBACK|SELECT|WITH|SET|TRUNCATE|UNLOAD|UNSET|UPDATE|UPSERT)+ skip=+\\\z1+ end=+\ze\z1+ contains=@SQL containedin=jsTemplateString keepend extend
endfunction

function! ToggleExtraGraphicalSymbols()
    set nu!
    set list!
    GitGutterToggle
    if exists('&signcolumn')
        if &signcolumn =~ "yes"
            set signcolumn=no
        else
            set signcolumn=yes
        endif
    endif
endfunction
"}}}

" Spell {{{
set spelllang=en,nb
set spellcapcheck=
hi SpellBad ctermbg=52
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
"}}}

" Remappings {{{

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
nnoremap <F4> :call ToggleExtraGraphicalSymbols()<CR>

" Leader mappings
map <silent> <leader>gs :Gstatus<cr>
map <silent> <leader>gd :Gdiff<cr>
map <leader>ge :Gedit<cr>
map <silent><leader>gr :Gread<cr>
map <silent><leader>gb :Gblame<cr>
map <silent><leader>gw :Gbrowse!<cr>
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
noremap <leader>minify :'<,'>!terser -m<CR>

" Nvim's terminal
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

"}}}

" Misc {{{

" Improved tab completion (:tabe awd<tab>)
set wildmode=longest,list,full
set wildmenu
set wildignore+=.git

" For tmux
set lazyredraw

" Hwo 2 witre plz
cnoreabbrev tbae tabe
cnoreabbrev taeb tabe
cnoreabbrev vps vsp
inoreabbrev requrie require
inoreabbrev esacpe escape
inoreabbrev articel article

" C-k + ./ => …
digraph ./ 8230

" Nicer window scrolling
set scrolloff=4
set sidescrolloff=15
set sidescroll=1

" Improve joining lines
set formatoptions& formatoptions+=mM

" Don't highlight tabs in projects that use tabs as indentation
if exists("g:loaded_EditorConfig")
    function! g:SetListChars(config)
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
nmap g] <C-w><C-]><C-w>T
set completeopt=longest,menuone

" I have local .vimrc in ~/.local/.vimrc
if filereadable(expand("$HOME") . "/.local/.vimrc")
    source $HOME/.local/.vimrc
endif
"}}}
