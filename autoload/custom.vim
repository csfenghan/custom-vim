
""""""""""""""""""
" 会话保存
""""""""""""""""""
let g:mp_save_name = ".session.save"

function custom#SessionSave() 
    if isdirectory(".git") 
        mksession! .session.vim
    endif
endfunction
function custom#SessionRestore() 
    let l:n = argc()
    if n == 0 && isdirectory(".git") && filereadable(".session.vim") 
        source .session.vim
        echo "Restore state from last state"
    endif
endfunction

""""""""""""""""""
" 批量注释
""""""""""""""""""
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


