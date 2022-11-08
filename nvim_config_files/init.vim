"NeoBundle Scripts-----------------------------
if has('vim_starting')  
  "source ~/.vim_runtime/vimrcs/extended.vim
endif
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sbdchd/neoformat'
" install ttf-joypixels with paru!
Plug 'junegunn/vim-emoji'
" rooter changes the working dir
Plug 'https://github.com/airblade/vim-rooter.git'
" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" custom UI 
Plug 'RishabhRD/popfix'
Plug 'romgrk/barbar.nvim'
Plug 'lewis6991/impatient.nvim'
Plug 'liuchengxu/vista.vim'
" navigator
" fix icons airline
Plug 'powerline/powerline-fonts'
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
Plug 'ray-x/navigator.lua'
" crates
Plug 'nvim-lua/plenary.nvim'
Plug 'saecki/crates.nvim'
Plug 'simrat39/rust-tools.nvim'
" Completion framework
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
" Debugging
Plug 'mfussenegger/nvim-dap'
"Open File Under Cursor
Plug 'https://github.com/amix/open_file_under_cursor.vim.git'
Plug 'https://github.com/jose-elias-alvarez/null-ls.nvim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/maxbrunsfeld/vim-yankstack.git'
Plug 'https://github.com/terryma/vim-expand-region.git'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/michaeljsmith/vim-indent-object.git'
Plug 'https://github.com/vim-scripts/nginx.vim.git'
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'edkolev/promptline.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
" On-demand loading
Plug 'a-vrma/black-nvim', {'do': ':UpdateRemotePlugins'}
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" MASONLSPCONFIG
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'williamboman/mason.nvim'
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
" Initialize plugin system
call plug#end()

autocmd VimEnter ` NERDTreeToggle

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

set laststatus=0
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
set completeopt=menuone,noinsert,noselect
set nocursorcolumn
set nocursorline
set updatetime=100
set pumheight=10
set clipboard+=unnamedplus
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
autocmd BufNewFile,BufRead *.c setlocal expandtab tabstop=2 shiftwidth=2 
autocmd BufNewFile,BufRead *.cpp setlocal expandtab tabstop=2 shiftwidth=2 
autocmd BufNewFile,BufRead *.rs setlocal expandtab tabstop=4 shiftwidth=4

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
nnoremap ` :NERDTreeToggle<CR> 

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
map Q: :q
map :Q :q
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

"
let g:NERDTreeWinPos = "right"

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


let g:UltSnipsListSnippets = "<tab>"

if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

" lets give a shot black fast settings
let g:black#settings = {
    \ 'fast': 1,
    \ 'line_length': 100
\}

" new promptline
let g:promptline_preset = 'full'
let g:promptline_theme = 'raven'
let g:airline_theme='raven'
let g:airline_powerline_fonts = 1
let bufferline = get(g:, 'bufferline', {})
let bufferline.no_name_title = v:null

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

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
let g:neoformat_run_all_formatters = 1
let g:neoformat_c_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 2}"']
\}
let g:neoformat_cpp_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{IndentWidth: 2}"']
\}
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_enabled_c = ['clangformat']

" codeactions
let g:code_action_menu_window_border = 'single'

" navigator setup
lua require('crates').setup()
lua require('terminal').config()

" TreeSitter Config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "bash", "c", "cmake", "cpp", "css", "dockerfile",  "help", "html", "http", "javascript", "json",  "make", "markdown", "python", "regex", "rust", "toml", "vim", "yaml" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF
lua <<EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
EOF
lua <<EOF
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua",
    "rust_analyzer", 
    "clangd",
    "pyright",
    }
})
require('mason-tool-installer').setup {
    ensure_installed = { 
    "autoflake", 
    "bash-language-server",
    "black",
    "clang-format",
    "cmakelang",
    "cpplint",
    "css-lsp",
    "jq",
    "jsonlint",
    "lua-language-server",
    "markdownlint",
    "rstcheck",
    "rustfmt",
    "vim-language-server",
  },
  auto_update = false,
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 1000, -- 3 second delay
}
require("lspconfig").sumneko_lua.setup {}
require("lspconfig").rust_analyzer.setup {}
-- WORKAROUND: WHY THE FUCK CLANGD RUNS TWO INSTANCE? require("lspconfig").clangd.setup {}
require("lspconfig").pyright.setup {
  capabilities = capabilities,
  filetypes = { "python" },
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        -- autoSearchPaths = true,
        -- useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "off",

      },
    },
  },
}
require'navigator'.setup({
  mason = true,
  lsp_installer = false,
  lsp = {
  enable = false,
  format_on_save = true,
  -- disable_lsp = "all",
  diagnostic = {
    underline = false, 
    virtual_text = false, 
    update_in_insert = true,
  },
  diagnostic_virtual_text = true,
  }
}
)

require("trouble").setup {
  auto_open = false, 
  auto_close = true, 
  auto_preview = true,
  mode = "workspace_diagnostics",
}
local diagnostics_active = false
vim.diagnostic.config{virtual_text=false}
vim.keymap.set('n', '<C-d>', function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = true,
      update_in_insert = true,
      underline = false, 
      severity_sort = true 
    }
)
vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = false,
  float = {
    source = "always", -- Or "if_many"
  },
})
EOF
" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" gruvbox dark
let g:gruvbox_contrast_dark='hard'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" stop using xclip
let g:clipboard = {
      \   'name': 'xsel_override',
      \   'copy': {
      \      '+': 'xsel --input --clipboard',
      \      '*': 'xsel --input --primary',
      \    },
      \   'paste': {
      \      '+': 'xsel --output --clipboard',
      \      '*': 'xsel --output --primary',
      \   },
      \   'cache_enabled': 1,
      \ }

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
execute "set t_8f=\e[38;2;%lu;%lu;%lum"
execute "set t_8b=\e[48;2;%lu;%lu;%lum"
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
" cursed remap settings
" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> g. :lua require'popui.diagnostics-navigator'()<CR>


" fuc 
nnoremap xx <cmd>TroubleToggle<cr>
noremap  <silent>  <C-S>          :update<CR>
noremap  <silent>  <F3>           :nohl<CR>
noremap  <silent>  <F1>           :Vista!!<CR>

noremap <silent> <C-t>         :tabnew<CR>
noremap <silent> <C-w>         :tabclose<CR>
nnoremap <C-DOWN> <C-W><C-J>
nnoremap <C-UP> <C-W><C-K>
nnoremap <C-RIGHT> <C-W><C-L>
nnoremap <C-LEFT> <C-W><C-H>
nnoremap <C-H> <C-A><Left>
nnoremap <C-J> <C-A><Down>
nnoremap <C-K> <C-A><Up>
nnoremap <C-L> <C-A><Right>

autocmd FileType cpp noremap <buffer> <F8> :Neoformat! cpp<CR>
autocmd FileType c noremap <buffer> <F8> :Neoformat! c<CR>

autocmd FileType python noremap <buffer> <F8> :Black<CR>
autocmd FileType python noremap <buffer> <F2> :!chmod +x ./% && ./%<CR>

autocmd FileType rust noremap <buffer> <F2> :RustRun<CR>
autocmd FileType rust noremap <buffer> <F5> :!cargo build<CR>
autocmd FileType rust   noremap <buffer> <F6> :!cargo run<CR>
autocmd FileType rust   noremap <buffer> <F7> :!cargo build --release<CR>

autocmd FileType asm   noremap <buffer> <F2> :!gcc -nostdlib -static ./% -o ./%:t:r.bin<CR>
autocmd FileType asm   noremap <buffer> <F3> :!objcopy --dump-section .text=./%:t:r-raw ./%:t:r.bin<CR>
autocmd FileType asm   noremap <buffer> <F4> :!./%:t:r.bin<CR>
autocmd FileType asm   noremap <buffer> <F5> :!strace ./%:t:r.bin<CR>
autocmd FileType asm   noremap <buffer> <F6> :!base64 -w0 ./%:t:r-raw<CR>

autocmd FileType python vnoremap <silent> # :s/^/#/<cr>:noh<cr>
autocmd FileType python vnoremap <silent> -# :s/^#//<cr>:noh<cr>
