""""""""""""""""""""""""""""
" 全局变量配置
""""""""""""""""""""""""""""
let s:plugindir = expand('<sfile>:p:h:h')
let s:config_file_name = "config.vim"
let s:config_file_path = custom#projectConfigPath()."/".s:config_file_name

""""""""""""""""""""""""""""
" 自动保存/恢复
""""""""""""""""""""""""""""
autocmd VimEnter * :call custom#SessionRestore()
autocmd VimLeave * :call custom#SessionSave()

""""""""""""""""""""""""""""
" coc配置
""""""""""""""""""""""""""""
set hidden              " TextEdit might fail if hidden is not set.
set nobackup            " Some servers have issues with backup files, see #649.
set nowritebackup
set cmdheight=2         " Give more space for displaying messages.
set updatetime=300
set shortmess+=c        " Don't pass messages to |ins-completion-menu|.

if has("nvim-0.5.0") || has("patch-8.1.1564")  " Always show the signcolumn,
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Add (Neo)Vim's native statusline support.
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

""""""""""""""""""""""""""""
" LeaderF
""""""""""""""""""""""""""""
" ignore files
let g:Lf_WildIgnore = {
        \ 'dir':['build', '.git'],
        \ 'file':['*.o', '*.a', '*.so']
      \ }

" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1

let g:Lf_WindowPosition = 'popup'       " popup mode
let g:Lf_PopupWidth = 0.8
let g:Lf_PopupHeight = 0.9
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'

""""""""""""""""""""""""""""
" coc-snippet
""""""""""""""""""""""""""""
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

""""""""""""""""""""""""""""
" vim-floaterm
""""""""""""""""""""""""""""
let g:floaterm_height=0.7
let g:floaterm_width=1.0

" 基于floaterm实现的快速命令功能

let g:quickCompileCommand = ""
let g:quickRunCommand = ""

function! QuickCommand(args, create)
    call custom#detectProjectDir()

    " 是否创建配置文件
    if filereadable(s:config_file_path)
        execute "source ".s:config_file_path
    endif
    
    " 选择
    let l:command = ""
    if a:args == "compile"
        let command = g:quickCompileCommand 
    elseif a:args == "run"
        let command = g:quickRunCommand
    endif

    if (command == "") 
        if filereadable(s:config_file_path)
            execute "e ".s:config_file_path
            return
        endif
        execute "!cp ".s:plugindir."/data/".s:config_file_name." ".s:config_file_path
        call feedkeys("\<CR>")
        execute "e ".s:config_file_path
        return
    endif

    " 运行
    let l:temp = @a
    let @a = command

    if a:create
        FloatermToggle<CR>
        call feedkeys("\<A-q>")
    endif
    set modifiable
    put a
    call feedkeys("A\<CR>")

    let @a = temp
endfunction


" 自动清除跳转记录
autocmd VimEnter * :clearjumps


""""""""""""""""""""""""""""
" nerdtree配置
""""""""""""""""""""""""""""
let g:NERDTreeWinSize=23
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif



""""""""""""""""""""""""""""
" vimspector配置
""""""""""""""""""""""""""""
function custom#VimspectorContinue() 
    call custom#detectProjectDir()

    if !filereadable(s:config_file_path)
        execute "!cp ".s:plugindir."/data/".s:config_file_name." ".s:config_file_path
        call feedkeys("\<CR>")
        execute "e ".s:config_file_path
        return
    endif
    execute "source ".s:config_file_path
    call feedkeys("\<Plug>VimspectorContinue")
endfunction

