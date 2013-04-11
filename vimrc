" Author: Johannes Lahann 
"
" Setup {{{1
set nocompatible
filetype on
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'YankRing.vim'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'vim-scripts/L9'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/tComment'
Bundle 'vim-scripts/xptemplate'
Bundle 'suan/vim-instant-markdown'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-haml'
Bundle 'kchmck/vim-coffee-script'

" Colorschemes
Bundle 'tpope/vim-vividchalk'
Bundle 'vim-scripts/mayansmoke'
Bundle 'altercation/vim-colors-solarized'
Bundle 'sjl/badwolf'

filetype plugin indent on
syntax on
set background=dark
colorscheme badwolf
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" Basics {{{1
let mapleader = ","
let maplocalleader = ",,"
set foldmethod=marker
set hidden
set lazyredraw
set cursorline
set encoding=utf-8
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set fillchars=diff:⣿,vert:│
set showmode
set wildmenu
set autoread
set backspace=2 "make backspace work like in other apps
set ignorecase
set incsearch
set list
set omnifunc=syntaxcomplete#Complete
set shiftwidth=4
set expandtab
set wildmode=list:longest,list:full
set showcmd
set smartcase
set smartindent
set laststatus=2
set spelllang=eng
set tabstop=4
set timeoutlen=600
set ttyfast
set wrapmargin=0
set linebreak
set display=lastline
" Backups {{{1

set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.
set history=1000
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif


" Gui {{{1
if has("gui_running")
	set guioptions-=T
	set guioptions-=r
	set guioptions-=R
	set guioptions-=m
	set guioptions-=l
	set guioptions-=L
	set guioptions=%t
endif
highlight SpellBad term=underline gui=undercurl guisp=Orange

" Different cursors for different modes.
set guicursor=n-c:block-Cursor-blinkon0
set guicursor+=v:block-vCursor-blinkon0
set guicursor+=i-ci:ver20-iCursor


" Mappings {{{1
"  Learnings {{{2
"
" Ack {{{2

nnoremap <leader>a :Ack!<space>
let g:ackprg = 'ag --nogroup --nocolor --column'

" }}}
" German Keyboard {{{2
map ü [
map! ü [
map ö (
map! ö (
map ä {
map! ä {
map ß \
map! ß \
map! oe &#x00F6;
map! Oe &#x00D6;
map! Ue &#x00DC;
map! ue &#x00FC;
map! Ae &#x00C4;
map! ae &#x00E4;
map! s# &#x00DF;
" Moving arround {{{2

nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>
" Useful stuff {{{2
nmap  <leader>p :set invpaste:set paste?
nmap  <leader>n :set invhls:set hls?
nmap  <leader>w :set invwrap:set wrap?
nmap  <leader>rr :1,$retab
nmap  <leader>cd :lcd %:h
nmap  <leader>md :!mkdir -p %:p:h

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_


" Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" Uppercase word
inoremap <C-u> <esc>mzgUiw`za

" Formatting, TextMate-style
nnoremap Q gqip
vnoremap Q gq

" Reformat line.  I never use l as a macro register anyway.
nnoremap ql gqq

" Easier linewise reselection
nnoremap <leader>V V`]

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Unfuck my screen
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>



" Folding {{{2
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO



" XPtemplate {{{2
nmap <C-F2> :XPTreload<Cr>
nmap <silent> ,et :XPTedit<cr>
command! XPTedit exe ":vnew ~/.vim/xptemplate_personal_snippets/ftplugin/".&ft."/".&ft.".xpt.vim"
"" Ack {{{

nnoremap <leader>a :Ack!<space>
let g:ackprg = 'ag --nogroup --nocolor --column'

" Plugins {{{1
" xptemplate {{{2
let g:xptemplate_snippet_folders = ['/home/johannes/dots/vim/xptemplate_personal_snippets']
let g:xptemplate_key='<C-Space>'
let g:xptemplate_key_pum_only='<LEADER><TAB>'
imap <C-D> <Tab>
let g:xptemplate_nav_chancel='<C-d>'
let g:xptemplate_nav_next='<Tab>'
let g:xptemplate_to_right='<C-_>'
let g:xptemplate_goback='<C-g>'




" latex- box {{{2
let g:LatexBox_viewer = 'evince'
let g:LatexBox_latexmk_options = '-pv'
let g:LatexBox_latexmk_options="-pdf"
let g:LatexBox_output_type="pdf"
let g:tex_flavor = "latex"



" Fugitive {{{2

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :Shell git gl -18<cr>:wincmd \|<cr>

augroup ft_fugitive
    au!

    au BufNewFile,BufRead .git/index setlocal nolist
augroup END

" "Hub"
nnoremap <leader>H :Gbrowse<cr>
vnoremap <leader>H :Gbrowse<cr>

" }}}
" Fuzzy Finder {{{2
nnoremap '<Space> :FufBookmarkDir<cr>
nnoremap '.  :FufFileWithCurrentBufferDir<cr>
nnoremap ''  :b#<cr>
nnoremap '/  :FufFile /<cr>
nnoremap 'd  :FufFile $HOME/Dropbox/<cr>
nnoremap 'f  :FufFile<cr>
nnoremap 'n  :e $HOME/Dropbox/Notes/markdown/<cr>
nnoremap 'c  :FufCoverageFile<cr>
nnoremap 'h  :FufFile $HOME/<cr>
nnoremap 'j  :FufFile $HOME/.vim/<cr>
nnoremap 'k  :FufBuffer<cr>
nnoremap 'l  :FufTag<cr>
nnoremap 'b  :e! $HOME/.bashrc<cr><cr>
nnoremap 't  :cd %:p:h<cr>:sh<cr>:cd -<cr>
nnoremap 'v  :e! $MYVIMRC<cr><cr>
let g:fuf_file_exclude = '\v\~$|\.(DS_Store|o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
" Surround.vim {{{2
let g:surround_42 = "**\r**"
nnoremap ** :exe "norm v$hS*"<cr>
nnoremap __ :exe "norm v$hS_"<cr>
vmap * S*
vmap _ S_
" taglist {{{2
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Auto_Update = 1
let Tlist_Auto_Highlight_Tag = 1
" tComment {{{2
let g:tcommentGuessFileType_markdown = 'html'

" Autocommands {{{1
"au BufWritePost *.tex Latexmk
au BufRead,BufNewFile *.md set filetype=markdown

augroup nonvim " {{{2
   au!
   au BufRead *.png,*.jpg,*.pdf,*.gif,*.xls*,*.scpt sil exe "!xdg-open " . shellescape(expand("%:p")) ."&" | bd | let &ft=&ft | redraw!
   " au BufRead *.ppt*,*.doc*,*.rtf sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
   au BufRead *.ppt*,*.doc*,*.rtf let g:output_pdf = shellescape(expand("%:r") . ".pdf")
   au BufRead *.ppt*,*.doc*,*.rtf sil exe "!$HOME/.bin/pdf " . shellescape(expand("%:p"))
   au BufRead *.ppt*,*.doc*,*.rtf sil exe "!xdg-open " . g:output_pdf | bd | let &ft=&ft | redraw!
augroup end

" Line Return {{{1

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Pandoc and Notes {{{1
let g:module = system('echo -n "$MODULE"')

nnoremap -md :w!<cr>:exe "!pandoc --latex-engine=pdflatex  -o $HOME/Dropbox/Notes/pdf/" . fnameescape(expand('%:t:r')) . ".pdf " . fnameescape(expand('%:p'))<cr>
nnoremap -mp :w!<cr>:exe "!pandoc --latex-engine=pdflatex  -o /tmp/" . fnameescape(expand('%:t:r')) . ".pdf " . fnameescape(expand('%:p')) . " && xdg-open /tmp/" . fnameescape(expand('%:t:r')) . ".pdf"<cr>

