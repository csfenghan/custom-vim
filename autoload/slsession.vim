
let g:mp_save_name = ".session.save"

function slsession#SessionSave() 
    if isdirectory(".git") 
        mksession! .session.vim
    endif
endfunction
function slsession#SessionRestore() 
    let l:n = argc()
    if n == 0 && isdirectory(".git") && filereadable(".session.vim") 
        source .session.vim
        echo "Restore state from last state"
    endif
endfunction
