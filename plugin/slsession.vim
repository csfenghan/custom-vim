""""""""""""""""""
" 会话处理
""""""""""""""""""

autocmd VimEnter * :call slsession#SessionRestore()
autocmd VimLeave * :call slsession#SessionSave()
