""""""""""""""""""""""""""""
" 自动保存/恢复
""""""""""""""""""""""""""""
autocmd VimEnter * :call custom#SessionRestore()
autocmd VimLeave * :call custom#SessionSave()
autocmd VimEnter * :clearjumps

