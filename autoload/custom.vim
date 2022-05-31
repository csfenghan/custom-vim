""""""""""""""""""
" 会话保存
""""""""""""""""""
let g:customAutoSave =  get(g:, "customAutoSave",v:false)
let g:session_path =  get(g:, "session_path","session.vim")

function custom#SessionSave() 
    if g:customAutoSave
        execute "mksession! ".g:session_path
    endif
endfunction

function custom#SessionRestore() 
    if !g:customAutoSave
        return
    endif

    let l:n = argc()
    if n == 0 && filereadable(g:session_path) 
        execute "source ".g:session_path
        echo "Restore state from last state"
    endif
endfunction

""""""""""""""""""
" 批量注释
""""""""""""""""""
let g:CommentType = {
        \ "c"       :   '//',
        \ "cpp"     :   '//',
        \ "python"  :   '#',
        \ "vim"     :   '"',
        \ "make"    :   "#"
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

