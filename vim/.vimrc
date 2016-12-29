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

nnoremap j gj
nnoremap k gk

vmap <C-c> "+y
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

set shiftwidth=4
set tabstop=4
set softtabstop=4
set noexpandtab

set modeline
set modelines=5
set foldlevel=5

set list
set listchars=tab:>-,trail:~,extends:>,precedes:<

"
" PLUGINS
"

" VimPlug
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'junegunn/seoul256.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/a.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'

call plug#end()

" Tagbar
let g:tagbar_left = 1
nmap <C-N><C-M> :TagbarToggle<CR>

" YouCompleteMe
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" a
nmap <C-M><C-M> :A<CR>

" fzf
nmap <leader>f :FZF<cr>

" ack
if executable('ag')
	let g:ackprg = 'ag --vimgrep'
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

"
" CUSTOM
"

" 81-symbol column highlight
let g:column_highlight = 0
function! SwitchColumnHighlight()
	if (g:column_highlight == 0)
		let g:column_highlight = 1
		set colorcolumn=81
	else
		let g:column_highlight = 0
		set colorcolumn=0
	endif
endfunction

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
