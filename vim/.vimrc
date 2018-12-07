set showmatch
set hlsearch
set incsearch
set number
set mouse=a
set ttymouse=urxvt
set laststatus=2
set backspace=2

set nofoldenable

let g:solarized_visibility="low"
set background=dark
colorscheme solarized

set shiftwidth=4
set tabstop=4
set softtabstop=4
set noexpandtab

set modeline
set modelines=5

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

set completeopt=menuone,noselect

au BufRead,BufNewFile *.c,*.cc,*.cpp,*.cxx,*.h,*.hpp,*.hxx set filetype=cpp.doxygen
au BufRead,BufNewFile *.qml set filetype=qml
au BufRead,BufNewFile *.m set filetype=octave
au BufRead,BufNewFile *.tex set fenc=utf-8 ts=2 sw=2 sts=2 et fdm=indent foldlevel=20
au FileType gitcommit set cc=72
au FileType qf set cc=0
au FileType qf nnoremap <buffer> <C-T> <C-W><CR><C-W>T
au FileType yaml set ts=4 sw=4 sts=4 et fdm=indent
au Syntax qml source $HOME/.vim/syntax/qml.vim

" 120-symbol column highlight
let g:column_highlight = 0
let g:column_number_highlight = 120
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
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-commentary'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-dispatch'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'kana/vim-operator-user'
Plug 'lyuts/vim-rtags'
Plug 'altercation/vim-colors-solarized', { 'do': 'cp -rf ./colors ~/.vim/' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'SirVer/ultisnips'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

call plug#end()

" a
nmap <C-M><C-M> :A<CR>

" ack
if executable('rg')
	let g:ackprg = 'rg --vimgrep --no-heading'
endif
let g:ack_use_dispatch = 1
nnoremap <leader>s :Ack -w <C-r><C-w><CR>


" CamelCaseMotion
call camelcasemotion#CreateMotionMappings(',')

" fzf
let g:fzf_layout = { 'down': '~30%' }
nmap <leader>b :Buffers<cr>
nmap <leader>f :FZF<cr>

" jedi
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 1

let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 0
au FileType python noremap <buffer> <Leader>rj :call jedi#goto()<CR>
au FileType python noremap <buffer> <Leader>ri :call jedi#show_documentation()<CR>
au FileType python noremap <buffer> <Leader>rw :call jedi#rename()<CR>
au FileType python noremap <buffer> <Leader>rf :call jedi#usages()<CR>

au FileType python setlocal omnifunc=jedi#completions

" NerdTree
map <leader>e :NERDTreeToggle<CR>
map <leader>t :NERDTreeFind<CR>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['flake8']

let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"

nnoremap <Leader>ml :SyntasticCheck<CR>
nnoremap <Leader>me :Errors<CR>

" vim-airlane
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:airline#extensions#whitespace#checks = [ 'indent', 'mixed-indent-file' ]

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = 'Ξ'

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
au FileType cpp.doxygen nnoremap <buffer> <Leader>mf :<C-u>ClangFormat<CR>
au FileType cpp.doxygen vnoremap <buffer> <Leader>mf :ClangFormat<CR>
let g:clang_format#detect_style_file = 1

" vim-fugitive
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gvdiff<CR>

" vim-rtags
let g:rtagsMinCharsForCommandCompletion = 1
au FileType cpp.doxygen setlocal omnifunc=RtagsCompleteFunc

let g:rtagsUseDefaultMappings = 0
au FileType cpp.doxygen noremap <buffer> <Leader>ri :call rtags#SymbolInfo()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rj :call rtags#JumpTo(g:SAME_WINDOW)<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rJ :call rtags#JumpTo(g:SAME_WINDOW, { '--declaration-only' : '' })<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rS :call rtags#JumpTo(g:H_SPLIT)<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rV :call rtags#JumpTo(g:V_SPLIT)<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rT :call rtags#JumpTo(g:NEW_TAB)<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rp :call rtags#JumpToParent()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rf :call rtags#FindRefs()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rF :call rtags#FindRefsCallTree()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rn :call rtags#FindRefsByName(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rs :call rtags#FindSymbols(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rr :call rtags#ReindexFile()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rl :call rtags#ProjectList()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rw :call rtags#RenameSymbolUnderCursor()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rv :call rtags#FindVirtuals()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rb :call rtags#JumpBack()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rC :call rtags#FindSuperClasses()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rc :call rtags#FindSubClasses()<CR>
au FileType cpp.doxygen noremap <buffer> <Leader>rd :call rtags#Diagnostics()<CR>

" ultisnips
set runtimepath+=~/.vim/snippets

let g:UltiSnipsExpandTrigger="<C-t>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" yapf
au FileType python nnoremap <buffer> <leader>mf :call yapf#YAPF()<cr>
