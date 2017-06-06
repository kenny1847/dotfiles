set showmatch
set hlsearch
set incsearch
set number
set mouse=a
set ttymouse=urxvt
set laststatus=2

set foldmethod=syntax

let g:seoul256_background = 234
colorscheme seoul256

set shiftwidth=4
set tabstop=4
set softtabstop=4
set noexpandtab

set modeline
set modelines=5
set foldlevel=5

set exrc
set secure

set wildmenu

set noswapfile
set nobackup
set nowritebackup

set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

au BufRead,BufNewFile *.c,*.cpp,*.cxx,*.h,*.hpp,*.hxx set filetype=cpp.doxygen
au BufRead,BufNewFile *.qml set filetype=qml
au BufRead,BufNewFile *.i set filetype=swig
au BufRead,BufNewFile *.vsh,*.psh set filetype=glsl
au BufRead,BufNewFile *.decl set filetype=qml
au BufRead,BufNewFile *.log set filetype=log
au BufRead,BufNewFile *.m set filetype=octave
au BufRead,BufNewFile *.tex set fenc=utf-8 ts=2 sw=2 sts=2 et fdm=indent foldlevel=20
au FileType gitcommit set cc=72
au FileType qf nnoremap <buffer> <C-T> <C-W><CR><C-W>T
au FileType qf set cc=0
au! Syntax qml source $HOME/.vim/syntax/qml.vim

" 160-symbol column highlight
let g:column_highlight = 0
let g:column_number_highlight = 160
function! SwitchColumnHighlight()
	if (g:column_highlight == 0)
		let g:column_highlight = 1
		execute "set colorcolumn=".g:column_number_highlight
		execute "set textwidth=".g:column_number_highlight
	else
		let g:column_highlight = 0
		set colorcolumn=0
		set textwidth=0
	endif
endfunction

nmap <C-B><C-B> :call SwitchColumnHighlight()<CR>

nnoremap j gj
nnoremap k gk
nnoremap <leader>w <C-w>
nnoremap <silent> <C-n> :nohl<CR>

vmap <C-c> "+y
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <leader>z :-tabmove<CR>
nnoremap <leader>x :+tabmove<CR>

inoremap <expr><C-n> pumvisible() ? '<C-n>' : '<C-X><C-U>'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction


" VimPlug
call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/a.vim'
Plug 'mileszs/ack.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/neocomplete.vim'
Plug 'junegunn/seoul256.vim', { 'do': 'cp -rf ./colors ~/.vim/' }
Plug 'tpope/vim-abolish'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-commentary'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'kana/vim-operator-user'
Plug 'lyuts/vim-rtags'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips'

call plug#end()


" a
nmap <C-M><C-M> :A<CR>


" ack
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif
if executable('rg')
	let g:ackprg = 'rg --vimgrep --no-heading'
endif
let g:ack_use_dispatch = 1
nnoremap <leader>s :Ack -w <C-r><C-w><CR>


" CamelCaseMotion
call camelcasemotion#CreateMotionMappings(',')


" fzf
let g:fzf_layout = { 'down': '~30%' }
nmap <leader>f :FZF<cr>


" NerdTree
map <leader>e :NERDTreeToggle<CR>
map <leader>t :NERDTreeFind<CR>


" NeoComplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#min_keyword_length = 4
let g:neocomplete#sources#dictionary#dictionaries = {'default' : '', 'vimshell' : $HOME.'/.vimshell_hist'}

if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
if !exists('g:neocomplete#delimiter_patterns')
	let g:neocomplete#delimiter_patterns= {}
endif
if !exists('g:neocomplete#sources')
	let g:neocomplete#sources = {}
endif
let g:neocomplete#sources.cpp = ['omni', 'UltiSnips']
let g:neocomplete#delimiter_patterns.cpp = ['::', '.', '->']

au FileType css setlocal omnifunc=csscomplete#CompleteCSS
au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType python setlocal omnifunc=pythoncomplete#Complete
au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

inoremap <expr><C-g> neocomplete#undo_completion()


" Tagbar
let g:tagbar_left = 1
nmap <leader>q :TagbarToggle<CR>


" vim-better-whitespace
autocmd BufWritePre * StripWhitespace


" vim-commentary
au FileType cpp.doxygen setlocal commentstring=//\ %s
au FileType octave setlocal commentstring=#\ %s
xmap <leader>c  <Plug>Commentary
nmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
nmap <leader>cu <Plug>Commentary<Plug>Commentary


" vim-clang-format
nnoremap <Leader>mf :<C-u>ClangFormat<CR>
vnoremap <Leader>mf :ClangFormat<CR>


" vim-fugitive
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gvdiff<CR>


" vim-rtags
let g:rtagsMinCharsForCommandCompletion = 1
au FileType cpp.doxygen setlocal omnifunc=RtagsCompleteFunc


" ultisnips
set runtimepath+=~/.vim/snippets

let g:UltiSnipsExpandTrigger="<C-t>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
