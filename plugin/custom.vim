" 自动保存/恢复
autocmd VimEnter * :call custom#SessionRestore()
autocmd VimLeave * :call custom#SessionSave()

" 批量注释
vnoremap <silent> <Leader>c :call Comment()<CR>
vnoremap <silent> <Leader>u :call UnComment()<CR>

