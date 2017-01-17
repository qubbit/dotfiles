set nocompatible

let g:plug_window = 'botright new | resize 10'

call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'andrewradev/splitjoin.vim'
Plug 'qualiabyte/vim-colorstepper'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'elixir-lang/vim-elixir'
Plug 'kchmck/vim-coffee-script'
Plug 'wincent/command-t'

Plug 'ntpeters/vim-better-whitespace'

Plug 'rhysd/vim-crystal'

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-signify'

" colors
Plug 'freeo/vim-kalisi'
Plug 'junegunn/seoul256.vim'
Plug 'romainl/Apprentice'
Plug 'robertmeta/nofrils'
Plug 'reedes/vim-colors-pencil'
Plug 'fxn/vim-monochrome'
Plug 'flazz/vim-colorschemes'

call plug#end()

cmap w!! w !sudo tee > /dev/null %

" ColorStepper Keys
nmap <F6> <Plug>ColorstepPrev
nmap <F7> <Plug>ColorstepNext
nmap <S-F7> <Plug>ColorstepReload

" format JSON (requires python obviously)
nmap =j :%!python -m json.tool<CR>

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

set history=1000

set list
set listchars=tab:>-,trail:_

set clipboard=unnamed

map <F2> :.w !pbcopy<CR><CR>
map <F3> :r !pbpaste<CR>

autocmd QuickFixCmdPost *grep* cwindow
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd Filetype php setlocal tabstop=4 shiftwidth=4
autocmd Filetype ruby setlocal tabstop=2 shiftwidth=2 expandtab

" color schemes
" colo seoul256
" let g:seoul256_background = 235
" let g:seoul256_light_background = 256
colo Monokai
set background=dark

" key bindings and what not
map <C-o> :NERDTreeToggle %<CR>

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

" exit out of normal mode with jj
imap <C-c> <Esc>

" ctrl-p
nmap <c-p> :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :Helptags<CR>
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|bundle|vendor)|(\.(swp|ico|git|svn))$'

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" Handy modifications for working on a laptop

" KeyHabits
" Attempt to force use of movement keys
imap <silent> <Up> :echo "Use k instead"<cr>
imap <silent> <Down> :echo "Use j instead"<cr>
imap <silent> <Left> :echo "Use h or a movement command instead"<cr>
imap <silent> <Right> :echo "Use l or a movement command instead"<cr>
imap <silent> <PageUp> <esc>:echo "Use <lt>C-B> instead"<cr>
imap <silent> <PageDown> <esc>:echo "Use <lt>C-F> instead"<cr>
imap <silent> <Home> <esc>:echo "Use 0 or ^ instead"<cr>
imap <silent> <End> <esc>:echo "Use $ instead"<cr>

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

filetype plugin indent on
set paste
set number
set hlsearch
set backspace=2
set cursorline
syntax enable

set tabstop=2
set shiftwidth=2
set expandtab
