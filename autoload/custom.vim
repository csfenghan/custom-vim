""""""""""""""""""
" 会话保存
""""""""""""""""""
let s:session_path = ".session.vim"

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

function custom#Comment() 
    let l:nowType = &filetype
    if has_key(g:CommentType, l:nowType)
        execute "s,^,".g:CommentType[l:nowType].",gg"
        :noh
    endif
endfunction

function custom#UnComment() 
    let l:nowType = &filetype
    if has_key(g:CommentType, l:nowType)
        execute "s,^".g:CommentType[l:nowType].",,gg"
        :noh
    endif
endfunction


""""""""""""""""""""""""""""
" 全局复制
""""""""""""""""""""""""""""
py3 import subprocess

function custom#VimGlobalClipboard() 
if !has("python3") 
    echo "Vim Glbal Clipboard need Python3!"
    return
endif
if $WSL_DISTRO_NAME == ""
    echo "Only support WSL!"
    return
endif

python3 << EOF
data = vim.eval("@0")
p = subprocess.Popen(['clip.exe'], stdin=subprocess.PIPE)
p.communicate(input=data.encode())
EOF
echo "Copy data to system clipboard"
endfunction

