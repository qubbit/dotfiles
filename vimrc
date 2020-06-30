set nocompatible

let g:fugitive_code_amazon_domains = ['ssh://git.amazon.com:2222']

set runtimepath^=~/pg/vim-fubitive/plugin/fubitive.vim
" use space as leader key
let mapleader = " "

let g:plug_window = 'botright new | resize 10'

if has('python3')
  silent! python3 1
endif

call plug#begin('~/.vim/plugged')

Plug 'jparise/vim-graphql'

" Java plugins

" Track the engine.
" Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" End Java plugins

Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
" Plug 'majutsushi/tagbar'
Plug 'andrewradev/splitjoin.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'wincent/command-t'
Plug 'mileszs/ack.vim'
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'


let os = substitute(system('uname'), '\n', '', '')

" if os == 'Darwin'
"   Plug '/usr/local/opt/fzf'
" elseif os == 'Linux'
"   Plug '~/.fzf'
" endif

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.dotfiles/fzf', 'do': '~/.dotfiles/fzf/install --all' }
Plug 'ruby-formatter/rufo-vim'

" enables readline shortcuts in command and insert mode
" Plug 'tpope/vim-rsi'

Plug 'ntpeters/vim-better-whitespace'

" languages and frameworks related
" Plug 'rhysd/vim-crystal'
" requires brew install clang-format
" Plug 'rhysd/vim-clang-format'

Plug 'pangloss/vim-javascript'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'prettier/vim-prettier', { 'for': ['html', 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

" status line
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'mhinz/vim-signify'

" colors
" Plug 'freeo/vim-kalisi'
" Plug 'junegunn/seoul256.vim'
" Plug 'dracula/vim'
" Plug 'romainl/Apprentice'
" Plug 'robertmeta/nofrils'
" Plug 'reedes/vim-colors-pencil'
" Plug 'fxn/vim-monochrome'
" Plug 'jacoborus/tender.vim'
" Plug 'mhartington/oceanic-next'
" Plug 'arcticicestudio/nord-vim'
" Plug 'gregsexton/Atom'
Plug 'danilo-augusto/vim-afterglow'

" Plug 'flazz/vim-colorschemes'
" Plug 'gorodinskiy/vim-coloresque'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

cmap w!! w !sudo tee > /dev/null %

" ColorStepper Keys
" nmap <F6> <Plug>ColorstepPrev
" nmap <F7> <Plug>ColorstepNext
" nmap <S-F7> <Plug>ColorstepReload

au FileType json setlocal equalprg=jq\ --indent\ 2\ .

" format XML (requires xmllint)
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
au FileType ruby setlocal equalprg=rufo

au FileType elixir nnoremap <buffer> <leader>d Orequire<space>IEx;<space>IEx.pry()<esc>
au FileType ruby nnoremap <buffer> <leader>d Orequire<space>'pry';<space>binding.pry<esc>
au FileType jsx, javascript nnoremap <buffer> <leader>d Odebugger;<esc>
au FileType tsx, typescript  nnoremap <buffer> <leader>d Odebugger;<esc>

au FileType typescript nnoremap <Leader>i "ayiwoconsole.log('<C-R>a:', <C-R>a);<Esc>
au FileType typescript xnoremap <Leader>i "ayoconsole.log('<C-R>a:', <C-R>a);<Esc>
au FileType javascript nnoremap <Leader>i "ayiwoconsole.log('<C-R>a:', <C-R>a);<Esc>
au FileType javascript xnoremap <Leader>i "ayoconsole.log('<C-R>a:', <C-R>a);<Esc>

au FileType elixir nnoremap <leader>i iIO.inspect<space><esc>==$
au FileType elixir nnoremap <leader>I "zyiwoIO.inspect<space><c-r>z,<space>label:<space>"<c-r>z"<esc>==$

set noswapfile
set history=1000
" allows switching buffers without saving them
" set hidden
set list
set listchars=tab:>-,trail:_
set clipboard=unnamed

map <F2> :.w !pbcopy<CR><CR>
map <F3> :r !pbpaste<CR>

autocmd QuickFixCmdPost *grep* cwindow
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd Filetype php setlocal tabstop=4 shiftwidth=4
autocmd Filetype ruby setlocal tabstop=2 shiftwidth=2 expandtab keywordprg=ri
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 noexpandtab nolist

" color schemes
silent! colorscheme afterglow

" some color schemes needs to be additionally configured
" based on things like current terminal background etc
" color seoul256
" let g:seoul256_background = 235
" let g:seoul256_light_background = 256
" colo Monokai
" set background=dark

" key bindings and what not
" map <C-o> :NERDTreeToggle %<CR>

set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

set visualbell t_vb=

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#whitespace#enabled = 1

let g:fugitive_github_domains = ['https://github.com', 'https://git.innova-partners.com']

imap <C-c> <Esc>

" ctrl-p
nmap <c-p> :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :Helptags<CR>
let g:ctrlp_custom_ignore = '\v[\/](build|_build|deps|node_modules|target|dist|bundle|vendor|tmp)|(\.(swp|ico|git|svn))$'
let g:ctrlp_working_path_mode = 'rc'

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" Handy modifications for working on a laptop

" KeyHabits
" Attempt to force use of movement keys
" imap <silent> <Up> :echo "Use k instead"<cr>
" imap <silent> <Down> :echo "Use j instead"<cr>
" imap <silent> <Left> :echo "Use h or a movement command instead"<cr>
" imap <silent> <Right> :echo "Use l or a movement command instead"<cr>
" imap <silent> <PageUp> <esc>:echo "Use <lt>C-B> instead"<cr>
" imap <silent> <PageDown> <esc>:echo "Use <lt>C-F> instead"<cr>
" imap <silent> <Home> <esc>:echo "Use 0 or ^ instead"<cr>
" imap <silent> <End> <esc>:echo "Use $ instead"<cr>

nmap <silent> <Up> :echo "Use k instead"<cr>
nmap <silent> <Down> :echo "Use j instead"<cr>
nmap <silent> <Left> :echo "Use h or a movement command instead"<cr>
nmap <silent> <Right> :echo "Use l or a movement command instead"<cr>
nmap <silent> <PageUp> :echo "Use <lt>C-B> instead"<cr>
nmap <silent> <PageDown> :echo "Use <lt>C-F> instead"<cr>
nmap <silent> <Home> :echo "Use 0 or ^ instead"<cr>
nmap <silent> <End> :echo "Use $ instead"<cr>

" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" rspec
nnoremap ,R :w<cr>:!bundle exec rspec %<cr>
nnoremap ,r :w<cr>:execute '!bundle exec rspec ' . expand('%') . ':' . line('.')<cr>

" filetype plugin indent on
"
" This set paste setting messes up my ctags for some reason
" set paste
set number
set hlsearch
set backspace=2
set cursorline
syntax enable

" add supports for JSX in JS files
let g:jsx_ext_required = 0

let g:ale_fix_on_save = 0
let g:prettier#autoformat = 0

let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#tab_width = 2
let g:prettier#quickfix_auto_focus = 0

map <leader>a ggVG
map <leader>o o<CR>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

nnoremap <silent> <leader>f mxgg=G`xzz

nmap <leader>rn <Plug>(coc-rename)

" use ag to search using the ack plugin
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set statusline+=%F
set tags=./tags,tags

" auto-format C and C++ code on save
let g:clang_format#auto_format=1
let g:clang_format#code_style="mozilla"

set tabstop=2     " Size of a hard tabstop (ts).
set shiftwidth=2  " Size of an indentation (sw).
set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
set autoindent    " Copy indent from current line when starting a new line.
set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
set expandtab     " Always uses spaces instead of tab characters (et).

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" Coc
let g:coc_node_path = substitute(system('which node'), '\n', '', '')

let g:coc_global_extensions = ['coc-html', 'coc-json', 'coc-css', 'coc-rls', 'coc-diagnostic', 'coc-prettier', 'coc-java', 'coc-tsserver', 'coc-eslint']
" let g:coc_global_extensions = ['coc-html', 'coc-json', 'coc-css', 'coc-rls', 'coc-java', 'coc-tsserver', 'coc-eslint']

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" nnoremap <F5> :CocRebuild<CR>
nnoremap <silent> <leader>g  :<C-u>CocList -I symbols<CR>
nnoremap <leader>o :CocCommand tsserver.organizeImports<CR>
nmap <leader>r <Plug>(coc-rename)
nmap <leader>s <Plug>(coc-codeaction)
nmap <leader>S <Plug>(coc-fix-current)
nmap <silent> <leader>a <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>A <Plug>(coc-diagnostic-next)
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>D <Plug>(coc-implementation)
nmap <silent> <leader>t <Plug>(coc-type-definition)

autocmd VimResized * wincmd =
