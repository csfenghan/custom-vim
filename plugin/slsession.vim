""""""""""""""""""
" 会话处理
""""""""""""""""""

autocmd VimEnter * :call slsession#SessionRestore()
autocmd VimLeave * :call slsession#SessionSave()

" 批量注释
"""""""""""""""""""""""""""start
let g:CommentType = {
        \ "c":'//',
        \ "cc":'//',
        \ "cpp":'//',
        \ "py":'#',
        \ "vim":'"'
      \ }
function Comment() 
    let l:nowType = &filetype
    if has_key(g:CommentType, l:nowType)
        execute "s,^,".g:CommentType[l:nowType].",gg"
        :noh
    endif
endfunction

function UnComment() 
    let l:nowType = &filetype
    if has_key(g:CommentType, l:nowType)
        execute "s,^".g:CommentType[l:nowType].",,gg"
        :noh
    endif
endfunction

vnoremap <silent> <Leader>c :call Comment()<CR>
vnoremap <silent> <Leader>u :call UnComment()<CR>
"""""""""""""""""""""""""""end
