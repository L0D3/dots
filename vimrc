" Bundles {{{1
if has('vim_starting')
set nocompatible               
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Lokaltog/vim-easymotion'
filetype plugin indent on

NeoBundleCheck

" Config {{{1 
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))
let s:is_sudo = $SUDO_USER != '' && $USER !=# $SUDO_USER
      \ && $HOME !=# expand('~'.$USER)
      \ && $HOME ==# expand('~'.$SUDO_USER)




syntax on
set autoindent
set autoread
set smartindent
set cmdheight=2
set number
set backspace=indent,eol,start
set showmatch 
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set expandtab
set clipboard=unnamed
set clipboard=unnamedplus 
" Config/Restore View {{{1
"if exists("g:loaded_restore_view")
"    finish
"endif
"let g:loaded_restore_view = 1
"
"
"if !exists("g:skipview_files")
"    let g:skipview_files = []
"endif
"
"function! MakeViewCheck()
"    if has('quickfix') && &buftype =~ 'nofile' | return 0 | endif
"    if expand('%') =~ '\[.*\]' | return 0 | endif
"    if empty(glob(expand('%:p'))) | return 0 | endif
"    if &modifiable == 0 | return 0 | endif
"    if len($TEMP) && expand('%:p:h') == $TEMP | return 0 | endif
"    if len($TMP) && expand('%:p:h') == $TMP | return 0 | endif
"
"    let file_name = expand('%:p')
"    for ifiles in g:skipview_files
"        if file_name =~ ifiles
"            return 0
"        endif
"    endfor
"
"    return 1
"endfunction
"
"augroup AutoView
"    autocmd!
"    " Autosave & Load Views.
"    autocmd BufWritePost,WinLeave,BufWinLeave ?* if MakeViewCheck() | mkview | endif
"    autocmd BufWinEnter ?* if MakeViewCheck() | silent! loadview | endif
"augroup END
" Config||Leader {{{1
let mapleader = ","
let maplocalleader="-"


" Plugins {{{1
" neocomplete {{{2
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'



" unite.vim {{{2
" s: Windows and buffers(High priority)
" The prefix key.
nnoremap    [Window]   <Nop>
nmap    s [Window]

" The prefix key.
nnoremap    [unite]   <Nop>
xnoremap    [unite]   <Nop>
nmap    ;u [unite]
xmap    ;u [unite]

nnoremap [unite]u  :Unite<Space>
" nnoremap <silent> :  :<C-u>Unite history/command command<CR>
nnoremap <expr><silent> ;b  <SID>unite_build()
function! s:unite_build()
  return ":\<C-u>Unite -buffer-name=build". tabpagenr() ." -no-quit build\<CR>"
endfunction
nnoremap <silent> ;o
      \ :<C-u>Unite outline -start-insert -resume<CR>
nnoremap  [unite]f  :<C-u>Unite source<CR>
nnoremap <silent> ;t
      \ :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
nnoremap <silent> ;w
      \ :<C-u>UniteWithCursorWord -buffer-name=register
      \ buffer file_mru bookmark file<CR>
nnoremap <silent> <C-k>
      \ :<C-u>Unite change jump<CR>
nnoremap <silent> ;g
      \ :<C-u>Unite grep -buffer-name=search -auto-preview -no-quit -no-empty -resume<CR>
nnoremap <silent> ;r
      \ :<C-u>Unite -buffer-name=register register history/yank<CR>
inoremap <silent><expr> <C-z>
      \ unite#start_complete('register', { 'input': unite#get_cur_text() })

" <C-t>: Tab pages
nnoremap <silent><expr> <C-t>
      \ ":\<C-u>Unite -select=".(tabpagenr()-1)." tab\<CR>"

if s:is_windows
  nnoremap <silent> [Window]s
        \ :<C-u>Unite -buffer-name=files -no-split -multi-line 
        \ jump_point file_point buffer_tab file_mru
        \ file_rec:! file file/new<CR>
else
  nnoremap <silent> [Window]s
        \ :<C-u>Unite -buffer-name=files -no-split -multi-line
        \ jump_point file_point buffer_tab file_mru
        \ file_rec/async:! file file/new<CR>
endif
nnoremap <silent> [Window]w
      \ :<C-u>Unite window<CR>
nnoremap <silent> [Space]b
      \ :<C-u>UniteBookmarkAdd<CR>

" t: tags-and-searches "{{{
" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Jump.
" nnoremap [Tag]t  g<C-]>
nnoremap <silent><expr> [Tag]t  &filetype == 'help' ?  "g\<C-]>" :
      \ ":\<C-u>UniteWithCursorWord -buffer-name=tag -immediately tag tag/include\<CR>"
nnoremap <silent><expr> [Tag]p  &filetype == 'help' ?
      \ ":\<C-u>pop\<CR>" : ":\<C-u>Unite jump\<CR>"

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
"}}}

" Execute help.
nnoremap <silent> <C-h>  :<C-u>Unite -buffer-name=help help<CR>
"}}}
" Colorscheme {{{1
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
set background=dark
colorscheme base16-railscasts
highlight clear SignColumn

" Filetype||Html {{{1
augroup ft_html
    au!
    au BufNewFile,BufRead *.html setlocal filetype=html
    au FileType html setlocal foldmethod=manual
augroup END

" Filetype||Vim {{{1
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
" XML folding
set foldnestmax=2
let g:xml_syntax_folding=0
augroup ft_xml
    au!
    au FileType xml setlocal foldmethod=syntax
augroup END
" Mappings  {{{1
" Make vim better on german keyboard
for s:c in map(range(65,90) + range(97,122),'nr2char(v:val)')
  exec 'nmap ö'.s:c.' ['.s:c
  exec 'xmap ö'.s:c.' ['.s:c
  exec 'nmap ä'.s:c.' ]'.s:c
  exec 'xmap ä'.s:c.' ]'.s:c
  exec 'nmap Ö'.s:c.' {'.s:c
  exec 'xmap Ö'.s:c.' {'.s:c
  exec 'nmap Ä'.s:c.' }'.s:c
  exec 'xmap Ä'.s:c.' }'.s:c
endfor
"Fix Some Movement
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
inoremap jk <esc>
nnoremap n nzzzv
nnoremap N Nzzzv
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>
" Easymotion
let g:EasyMotion_mapping_f = 'f'
let g:EasyMotion_mapping_F = 'F'
let g:EasyMotion_mapping_T = 'T'
let g:EasyMotion_mapping_t = 't'

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_
" Paste
nnoremap <leader>p o<esc>p
set scroll=15
" Folds
nnoremap <space> za
vnoremap <space> zf

" Vimrc 
nnoremap <leader>sv  :source ~/.vimrc<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>				

" Upper case
inoremap <c-u> <esc>viWU<esc>Ea
nnoremap <c-u> vaWU
