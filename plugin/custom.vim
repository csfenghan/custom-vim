""""""""""""""""""""""""""""
" 全局变量配置
""""""""""""""""""""""""""""
let s:plugindir = expand('<sfile>:p:h:h')
let s:config_file_name = "config.vim"
let s:config_file_path = custom#projectConfigPath()."/".s:config_file_name

if filereadable(s:config_file_path)
    execute "source ".s:config_file_path
endif
if filereadable(".workspace.vim")
    execute "source .workspace.vim"
endif


""""""""""""""""""""""""""""
" 自动命令
""""""""""""""""""""""""""""
autocmd VimEnter * :call custom#SessionRestore()
autocmd VimLeave * :call custom#SessionSave()
autocmd VimEnter * :clearjumps

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
function! g:Show_documentation()
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
let g:floaterm_width=0.7
hi FloatermBorder guibg=orange guifg=cyan

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

""""""""""""""""""""""""""""
" buffline.nvim配置
""""""""""""""""""""""""""""
lua << EOF
require('bufferline').setup {
  highlights = {
    buffer_selected = {
      gui="italic" 
    }        
  },
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers = "none" ,
    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = false,
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
      -- filter out by it's index number in list (don't show first buffer)
      if buf_numbers[1] ~= buf_number then
        return true
      end
    end,
    --offsets = {{filetype = "NvimTree", text = "File Explorer" | function , text_align = "left" | "center" | "right"}},
    color_icons = false, -- whether or not to add the filetype icon highlights
    show_buffer_icons = false, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_buffer_default_icon = false, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = false,
    show_tab_indicators = false,
    persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant" ,--| "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    --sort_by = 'insert_after_current' 
      -- add custom logic
      --return buffer_a.modified > buffer_b.modified
  }
}

EOF


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

