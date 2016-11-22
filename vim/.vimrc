set showmatch
set hlsearch
set incsearch
set ignorecase
set number
set mouse=a

set foldmethod=syntax

let g:seoul256_background = 234
colorscheme seoul256

nnoremap j gj
nnoremap k gk

vmap <C-c> "+y
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

set shiftwidth=4
set tabstop=4
set softtabstop=4
set noexpandtab

set modeline
set modelines=5
set foldlevel=4

"
" PLUGINS
"

" VimPlug
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'junegunn/seoul256.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'

call plug#end()

" NERDTree
nmap <C-N><C-N> :NERDTreeToggle<cr>
vmap <C-N><C-N> <esc>:NERDTreeToggle<cr>i
imap <C-N><C-N> <esc>:NERDTreeToggle<cr>i

" Tagbar
nmap <C-N><C-M> :TagbarToggle<CR>

" YouCompleteMe
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1 
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

"
" CUSTOM
" 

" Source-Header Toggle
let g:source_header_switch = 1
function! SwitchSourceHeader()
	if (expand ("%:e") == "cpp")
		let g:source_header_switch = 1
		find %:t:r.h
	elseif (expand ("%:e") == "c")
		let g:source_header_switch = 2
		find %:t:r.h
	elseif g:source_header_switch == 1
		find %:t:r.cpp
	else 
		find %:t:r.c
	endif
endfunction

" 121-symbol column highlight
let g:column_highlight = 0
function! SwitchColumnHighlight()
	if (g:column_highlight == 0)
		let g:column_highlight = 1
		set colorcolumn=121
	else 
		let g:column_highlight = 0
		set colorcolumn=0
	endif
endfunction

nmap <C-M><C-M> :call SwitchSourceHeader()<CR>
nmap <C-B><C-B> :call SwitchColumnHighlight()<CR>

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Autoreload vim config
autocmd! bufwritepost ~/.vimrc execute "normal! :source ~/.vimrc"

au BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp set filetype=cpp.doxygen
au BufRead,BufNewFile *.qml set filetype=qml
au BufRead,BufNewFile *.i set filetype=swig
au BufRead,BufNewFile *.vsh,*.psh set filetype=glsl
au BufRead,BufNewFile *.decl set filetype=qml
au BufRead,BufNewFile *.log set filetype=log
au! Syntax qml source $HOME/.vim/syntax/qml.vim
