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

set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

au BufRead,BufNewFile *.c,*.cpp,*.cxx,*.h,*.hpp,*.hxx set filetype=cpp.doxygen
au BufRead,BufNewFile *.qml set filetype=qml
au BufRead,BufNewFile *.i set filetype=swig
au BufRead,BufNewFile *.vsh,*.psh set filetype=glsl
au BufRead,BufNewFile *.decl set filetype=qml
au BufRead,BufNewFile *.log set filetype=log
au! Syntax qml source $HOME/.vim/syntax/qml.vim

" 80-symbol column highlight
let g:column_highlight = 0
let g:column_number_highlight = 80
function! SwitchColumnHighlight()
	if (g:column_highlight == 0)
		let g:column_highlight = 1
		execute "set colorcolumn=".g:column_number_highlight
	else
		let g:column_highlight = 0
		set colorcolumn=0
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

autocmd FileType qf nnoremap <buffer> <C-T> <C-W><Enter><C-W>T
autocmd FileType qf set cc=0


" VimPlug
call plug#begin('~/.vim/plugged')

Plug 'bkad/CamelCaseMotion'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'lyuts/vim-rtags'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'SirVer/ultisnips'
Plug 'vim-scripts/a.vim'

call plug#end()


" Tagbar
let g:tagbar_left = 1
nmap <leader>q :TagbarToggle<CR>


" NeoComplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#min_keyword_length = 1
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

function! SetupNeocomleteForCppWithRtags()
	setlocal omnifunc=RtagsCompleteFunc

	if !exists('g:neocomplete#sources#omni#input_patterns')
		let g:neocomplete#sources#omni#input_patterns = {}
	endif
	let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
	set completeopt+=longest,menuone
endfunction

autocmd FileType cxx,cpp,c,h,hpp,hxx call SetupNeocomleteForCppWithRtags()
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" rtags
let g:rtagsMinCharsForCommandCompletion = 2


" a
nmap <C-M><C-M> :A<CR>


" fzf
let g:fzf_layout = { 'down': '~30%' }
nmap <leader>f :FZF<cr>


" ack
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif
if executable('rg')
	let g:ackprg = 'rg --vimgrep --no-heading'
endif
let g:ack_use_dispatch = 1
nnoremap <leader>s :Ack -w <C-r><C-w><CR>


" vim-better-whitespace
autocmd BufWritePre * StripWhitespace


" ultisnips
set runtimepath+=~/.vim/snippets

let g:UltiSnipsExpandTrigger="<C-t>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"


" CamelCaseMotion
call camelcasemotion#CreateMotionMappings(',')


" NerdTree
map <leader>e :NERDTreeToggle<CR>
map <leader>t :NERDTreeFind<CR>
