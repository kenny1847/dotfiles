au FileType yaml set ts=4 sw=4 sts=4 et
au FileType cpp.doxygen set ts=4 sw=4 sts=4 et
au FileType cpp.doxygen let g:column_number_highlight = 120
autocmd BufNewFile,BufRead arc-rebase-todo setf gitrebase

au FileType python let g:column_number_highlight = 120

function! GetArcadiaLink()
" rev=<rev_no>
    echom "https://a.yandex-team.ru/arc_vcs/" . expand("%") . "#L" . line(".")
endfunction
nnoremap <leader>V :call GetArcadiaLink()<CR>

nnoremap <leader>ys :!ya style %<CR>
nnoremap <leader>yf :!ya style --all %<CR>
