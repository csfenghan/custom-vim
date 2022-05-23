
"""""""""""""""""""""""""""""""""
" 跳转
"""""""""""""""""""""""""""""""""
nmap <silent> gd    <Plug>(coc-definition)
nmap <silent> gc    <Plug>(coc-declaration)
nmap <silent> gr    <Plug>(coc-references)

"""""""""""""""""""""""""""""""""
" 语法诊断与辅助功能
"""""""""""""""""""""""""""""""""
nmap <silent> [g    <Plug>(coc-diagnostic-prev)
nmap <silent> ]g    <Plug>(coc-diagnostic-next)
nmap <silent> K     :call <SID>show_documentation()<CR>

nmap <silent> gn    <Plug>(coc-git-prevchunk)
nmap <silent> gp    <Plug>(coc-git-nextchunk)
nmap <silent> cn    <Plug>(coc-git-prevconflict)
nmap <silent> cp    <Plug>(coc-git-nextconflict)

"""""""""""""""""""""""""""""""""
" 文件管理与buffer管理
"""""""""""""""""""""""""""""""""
nmap <silent> <C-p>     :LeaderfFile<CR>
nmap <silent> <C-m>     :LeaderfFunction<CR>
nmap <silent> <C-g>     :LeaderfBufTag<CR>
nmap <silent> <leader>b :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
nmap <silent> <leader>m :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>

" buffer显示
nmap <silent> <A-l>     :bn<CR>
imap <silent> <A-l>     <ESC>:bn<CR>
nmap <silent> <A-h>     :bp<CR>
imap <silent> <A-h>     :<ESC>bp<CR>
nmap <silent> <A-k>     :bd<CR>

" 文件树
nnoremap <C-t> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""
" 终端和快捷命令
"""""""""""""""""""""""""""""""""
nmap <silent>  <A-t>    :FloatermNew<CR>
tmap <silent>  <A-t>    <C-\><C-n>:FloatermNew<CR>
tmap <silent>  <A-k>    <C-\><C-n>:FloatermKill<CR>
tmap <silent>  <A-h>    <C-\><C-n>:FloatermPrev<CR>
tmap <silent>  <A-l>    <C-\><C-n>:FloatermNext<CR>
nmap <silent>  <A-=>    :FloatermToggle<CR>
tmap <silent>  <A-=>    <C-\><C-n>:FloatermToggle<CR>
tmap <silent>  <A-q>    <c-\><c-n> 

" 快捷命令
let g:configFilePath = ".workspace.vim"
nmap <silent>  <F5>     :call QuickCommand(g:quickRunCommand, 1)<CR>
tmap <silent>  <F5>     <C-\><C-n>:call QuickCommand(g:quickRunCommand, 0)<CR>
nmap <silent>  <F6>     :call QuickCommand(g:quickCompileCommand, 1)<CR>
tmap <silent>  <F6>     <C-\><C-n>:call QuickCommand(g:quickCompileCommand, 0)<CR>
