" NeoBundle Scripts-----------------------------
if has('vim_starting')  
  "source ~/.vim_runtime/vimrcs/extended.vim
.
endif
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
" rooter changes the working dir
Plug 'https://github.com/airblade/vim-rooter.git'
" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"Open File Under Cursor
Plug 'https://github.com/amix/open_file_under_cursor.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/terryma/vim-expand-region.git'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
Plug 'https://github.com/maxbrunsfeld/vim-yankstack.git'
Plug 'https://github.com/amix/vim-zenroom2.git'
Plug 'https://github.com/leafgarland/typescript-vim.git'
Plug 'https://github.com/Vimjas/vim-python-pep8-indent.git'
Plug 'https://github.com/vim-scripts/nginx.vim.git'
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kassio/neoterm'
"Plug 'itchyny/lightline.vim', {'branch': 'release'}
" lets go for airline exp
Plug 'vim-airline/vim-airline'
Plug 'edkolev/promptline.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" NERDTree to CHADTree
"Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
" On-demand loading
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'a-vrma/black-nvim', {'do': ':UpdateRemotePlugins'}

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }


" Initialize plugin system
call plug#end()




nmap jj :helptags ~/.vim/doc<CR>
autocmd VimEnter * NERDTreeToggle

set nocompatible
filetype on
filetype plugin indent on
set clipboard +=unnamed
set go+=a
set ttyfast
set undodir=~/.vim_runtime/undodir
set undofile 
set termguicolors
let g:python3_host_prog='/usr/bin/python3'
let g:python_host_prog='/usr/bin/python2.7'

set laststatus=2
set encoding=utf-8
set autoread
set autoindent
set backspace=indent,eol,start
set incsearch
set hlsearch
set mouse=a


set noerrorbells
set showcmd
set noswapfile
set nobackup
set splitright
set splitbelow
set autowrite
set hidden
set fileformats=unix,dos,mac
set noshowmatch
set noshowmode
set ignorecase
set smartcase
set completeopt=menu,menuone,preview
set nocursorcolumn
set nocursorline
set updatetime=100
set pumheight=10
set clipboard^=unnamed
set clipboard^=unnamedplus
set viminfo='200
set lazyredraw

" experimental
set shortmess+=c
set signcolumn=yes


syntax on

set wrapmargin=10
set number
set background=dark
colorscheme gruvbox_edited

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" filetypes

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
autocmd BufNewFile,BufRead *.c setlocal noexpandtab tabstop=2 shiftwidth=2 

autocmd BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4
autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2

autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2

augroup filetypedetect
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.hcl setf conf
augroup END

" STATUS "

let s:modes = {
      \ 'n': 'NORMAL', 
      \ 'i': 'INSERT', 
      \ 'R': 'REPLACE', 
      \ 'v': 'VISUAL', 
      \ 'V': 'V-LINE', 
      \ "\<C-v>": 'V-BLOCK',
      \ 'c': 'COMMAND',
      \ 's': 'SELECT', 
      \ 'S': 'S-LINE', 
      \ "\<C-s>": 'S-BLOCK', 
      \ 't': 'TERMINAL'
      \}

let s:prev_mode = ""

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
"===================== MAPPINGS ======================

" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let mapleader = "."

" Some useful quickfix shortcuts for quickfix
map <C-n> :cn<CR>
map <C-m> :cp<CR>

" put quickfix window always to the bottom
autocmd FileType qf wincmd J
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

" Center the screen
nnoremap <space> zz

" Close all but the current one
nnoremap <leader>o :only<CR>

" é to toggle tree
nnoremap " :NERDTreeToggle<CR> 

" i dont fucking like cut D
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d


let mapleader = "."
let g:mapleader = "."

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Print full path
map <C-x> :echo expand("%:p")<cr>

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Exit on jk
imap jk <Esc>

nnoremap <F6> :setlocal spell! spell?<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" Act like D and C
nnoremap Y y$

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

" Do not show stupid q: window
map q: :q
command Q q

" Don't move on * I'd use a function for this but Vim clobbers the last search
" when you're in a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
if has('gui_running')
  set notimeout
  set ttimeout
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Visual Mode */# from Scrooloose {{{
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" FZF key bindings
nnoremap <C-f> :FZF<CR>
"let g:fzf_action = {
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-i': 'split',
"  \ 'ctrl-v': 'vsplit' }

" Search pattern across repository files
function! FzfExplore(...)
    let inpath = substitute(a:1, "'", '', 'g')
    if inpath == "" || matchend(inpath, '/') == strlen(inpath)
        execute "cd" getcwd() . '/' . inpath
        let cwpath = getcwd() . '/'
        call fzf#run(fzf#wrap(fzf#vim#with_preview({'source': 'ls -1ap', 'dir': cwpath, 'sink': 'FZFExplore', 'options': ['--prompt', cwpath]})))
    else
        let file = getcwd() . '/' . inpath
        execute "e" file
    endif
endfunction

command! -nargs=* FZFExplore call FzfExplore(shellescape(<q-args>))


"
" endless configure dontttcha
set nosmd
set noru
set laststatus=2
set cmdheight=1

" Coc-Snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
"
let g:NERDTreeWinPos = "right"

"let g:UltiSnipsSnippetsDir = '/home/echelon/.config/nvim/UltiSnips/'
""let g:UltiSnipsSnippetDirectories = ['UltiSnips']

"let g:UltiSnipsEditSplit="vertical"
"let g:UltiSnipsExpandTrigger="<TAB>"
"let g:UltiSnipsJumpForwardTrigger="<s-tab>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"=
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
" oynat uurcum
map tt :T source ~/.promptline.sh<cr><C-W><C-W>i
map TT :Ttoggle<cr>
map tc :TcloseAll<cr>
map to :tabonly<cr>

" lets give a shot black fast settings
let g:black#settings = {
    \ 'fast': 1,
    \ 'line_length': 80
\}

" new promptline
let g:promptline_preset = 'full'
let g:promptline_theme = 'raven'
let g:airline_theme='raven'
" sections (a, b, c, x, y, z, warn) are optional
let g:promptline_preset = {
        \'b' : [ promptline#slices#user() ],
        \'c' : [ promptline#slices#cwd() ],
        \'y' : [ promptline#slices#vcs_branch() ],
        \'warn' : [ promptline#slices#last_exit_code() ]}
let g:promptline_preset = {
      \'a'    : [ '\h' ],
      \'b'    : [ '\u' ],
      \'c'    : [ '\w' ]}

" custom setting for clangformat
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 2}"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']



" open terminal at bottom of window
let g:neoterm_default_mod = 'botright'

" gruvbox dark
let g:gruvbox_contrast_dark='hard'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1


let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
execute "set t_8f=\e[38;2;%lu;%lu;%lum"
execute "set t_8b=\e[48;2;%lu;%lu;%lum"

" cursed remap settings
noremap  <silent>  <C-S>          :update<CR>
noremap  <silent>  <F3>           :nohl<CR>
noremap <silent> <C-t>         :tabnew<CR>
noremap <silent> <C-w>         :tabclose<CR>
autocmd FileType python noremap <buffer> <F8> :call Black()<CR>
autocmd FileType python noremap <buffer> <F2> :!chmod +x ./% && ./%<CR>

autocmd FileType asm   noremap <buffer> <F2> :!gcc -nostdlib -static ./% -o ./%:t:r.bin<CR>
autocmd FileType asm   noremap <buffer> <F3> :!objcopy --dump-section .text=./%:t:r-raw ./%:t:r.bin<CR>
autocmd FileType asm   noremap <buffer> <F4> :!./%:t:r.bin<CR>
autocmd FileType asm   noremap <buffer> <F5> :!strace ./%:t:r.bin<CR>
autocmd FileType asm   noremap <buffer> <F6> :!base64 -w0 ./%:t:r-raw<CR>
autocmd FileType python vnoremap <silent> # :s/^/#/<cr>:noh<cr>
autocmd FileType python vnoremap <silent> -# :s/^#//<cr>:noh<cr>
