""""""""""""""""""
" 自动创建工程目录
""""""""""""""""""
let g:projectConfigPath = ".project"
function custom#projectConfigPath()
    return g:projectConfigPath
endfunction

function custom#detectProjectDir() 
    if !isdirectory(g:projectConfigPath)
        execute "!mkdir ".g:projectConfigPath
    endif
endfunction
""""""""""""""""""
" 会话保存
""""""""""""""""""
let s:session_name = ".session.vim"
let s:session_path = g:projectConfigPath."/".s:session_name

function custom#SessionSave() 
    call custom#detectProjectDir()
    if isdirectory(".git") 
        execute "mksession! ".s:session_path
    endif
endfunction

function custom#SessionRestore() 
    let l:n = argc()
    if n == 0 && isdirectory(".git") && filereadable(s:session_path) 
        execute "source ".s:session_path
        echo "Restore state from last state"
    endif
endfunction

""""""""""""""""""
" 批量注释
""""""""""""""""""
let g:CommentType = {
        \ "c"   :   '//',
        \ "cc"  :   '//',
        \ "cpp" :   '//',
        \ "py"  :   '#',
        \ "vim" :   '"',
        \ "make":   "#"
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


