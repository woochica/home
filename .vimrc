" Repa's vimrc
" Recommended plugins:
" taglist:    http://www.vim.org/scripts/script.php?script_id=273
" netrw:      http://www.vim.org/scripts/script.php?script_id=1075
" vimblog:    http://www.vim.org/scripts/script.php?script_id=2030
" snippets:   http://www.vim.org/scripts/script.php?script_id=1318
" vcscommand: http://www.vim.org/scripts/script.php?script_id=90 
" VE:         http://www.vim.org/scripts/script.php?script_id=1950

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Szinek beallitasa
  hi Normal               guibg=#101020 guifg=#f0f0f0
  hi Normal               ctermfg=white ctermbg=black
  "hi Normal               guifg=white guibg=darkblue
  hi String               ctermfg=Green
  hi String               guifg=Green
  hi Number               ctermfg=LightGreen
  hi Number               guifg=LightGreen
  hi Boolean              ctermfg=LightGreen
  hi Boolean              guifg=LightGreen
  hi Float                ctermfg=LightGreen
  hi Float                guifg=LightGreen
  hi Operator             ctermfg=Yellow
  hi Operator             guifg=Yellow
  hi Repeat               ctermfg=Red
  hi Repeat               guifg=Red
  hi ErrorMsg             ctermfg=white ctermbg=red
  hi ErrorMsg             guifg=white guibg=red
  hi Visual               ctermbg=darkyellow ctermfg=darkcyan term=reverse
  hi Visual               guibg=#a0b020 guifg=darkblue
  hi VisualNOS            ctermbg=black ctermfg=darkcyan cterm=reverse,underline
  hi Todo                 ctermfg=red   ctermbg=darkblue gui=reverse,underline
  hi Todo                 guifg=red guibg=darkblue
  hi Search               ctermfg=yellow ctermbg=darkgreen
  hi Search               guifg=lightgreen guibg=darkgreen
  hi IncSearch            ctermfg=black ctermbg=darkyellow cterm=bold,reverse,underline term=underline
  hi IncSearch            guifg=black guibg=darkyellow gui=bold,reverse
                                                                                
  hi SpecialKey           ctermfg=darkcyan
  hi SpecialKey           guifg=darkcyan
  hi Directory            ctermfg=cyan
  hi Directory            guifg=cyan
  hi Title                ctermfg=magenta cterm=bold
  hi Title                guifg=magenta gui=bold
  hi WarningMsg           ctermfg=red
  hi WarningMsg           guifg=red
                                                                                
  hi WildMenu             ctermfg=yellow ctermbg=black cterm=none term=none
  hi WildMenu             guifg=yellow guibg=black gui=none
  hi ModeMsg              ctermfg=yellow
  hi ModeMsg              guifg=yellow
  hi MoreMsg              ctermfg=darkgreen
  hi MoreMsg              guifg=darkgreen
  hi Question             ctermfg=green cterm=none
  hi Question             guifg=green gui=none
  hi NonText              ctermfg=lightMagenta
  hi NonText              guifg=lightMagenta
                                                                                
  hi StatusLine           ctermfg=blue ctermbg=gray term=none cterm=none
  hi StatusLine           guifg=blue guibg=gray gui=none
  hi StatusLineNC         ctermfg=black ctermbg=gray term=none cterm=none
  hi StatusLineNC         guifg=black guibg=gray gui=none
  hi VertSplit            ctermfg=black ctermbg=gray term=none cterm=none
  hi VertSplit            guifg=black guibg=gray gui=none
                                                                                
  hi Folded               ctermfg=darkgrey ctermbg=black cterm=bold term=bold
  hi Folded               guifg=darkgrey guibg=black gui=bold
  hi FoldColumn           ctermfg=darkgrey ctermbg=black cterm=bold term=bold
  hi FoldColumn           guifg=darkgrey guibg=black gui=bold
  hi LineNr               ctermbg=black ctermfg=green cterm=none
  hi LineNr               guibg=#080840 guifg=green gui=none
                                                                                
  hi DiffAdd              ctermbg=darkblue term=none cterm=none
  hi DiffAdd              guibg=darkblue gui=none
  hi DiffChange           ctermbg=magenta cterm=none
  hi DiffChange           guibg=magenta gui=none
  hi DiffDelete           ctermfg=blue ctermbg=cyan
  hi DiffDelete           guifg=blue guibg=cyan
  hi DiffText             cterm=bold ctermbg=red
  hi DiffText             gui=bold guibg=red
                                                                                
  hi Cursor               ctermfg=bg ctermbg=fg
  hi Cursor               guifg=bg guibg=fg
  hi lCursor              ctermfg=bg ctermbg=darkgreen
  hi lCursor              guifg=bg guibg=darkgreen
  hi Comment              ctermfg=brown cterm=none term=none
  hi Comment              guifg=blue gui=italic
  hi Constant             ctermfg=darkgreen
  hi Constant             guifg=green
  hi Special              ctermfg=green
  hi Special              guifg=lightcyan
  hi Identifier           ctermfg=cyan cterm=none
  hi Identifier           guifg=cyan gui=none
  hi Statement            ctermfg=yellow
  hi Statement            guifg=yellow
  hi PreProc              ctermfg=lightred cterm=bold
  hi PreProc              guifg=red gui=bold
  hi type                 ctermfg=darkYellow cterm=bold
  hi type                 guifg=darkYellow gui=bold
  hi Underlined           cterm=underline term=underline
  hi Underlined           gui=underline
  hi Ignore               ctermfg=darkcyan
  hi Ignore               guifg=bg

  " Status line
  hi User1                ctermbg=darkblue ctermfg=cyan
  hi User1                guibg=#080840 guifg=cyan
  hi User2                ctermbg=darkblue ctermfg=white
  hi User2                guibg=#080840 guifg=white
  hi User3                ctermbg=darkblue ctermfg=green
  hi User3                guibg=#080840 guifg=green
  hi User4                ctermbg=darkblue ctermfg=blue
  hi User4                guibg=#080840 guifg=#202050

if v:version >= 700
  hi CursorLine           guibg=#403820
  hi CursorColumn         guibg=#403820

  hi MatchParen           ctermbg=White guibg=White guifg=DarkGreen ctermfg=DarkGreen

  hi Pmenu                guifg=Black guibg=#C4C090 ctermfg=LightGreen ctermbg=DarkGreen
  hi PmenuSel             guifg=Black guibg=#FFBF00 ctermfg=LightGreen ctermbg=Black
  hi PmenuSbar            guifg=Black guibg=LightGray
  hi PmenuThumb           guifg=Black guibg=White gui=NONE

  hi TabLine              guifg=Black guibg=#A4A090 gui=NONE
  hi TabLineFill          guifg=Black guibg=#A4A090 gui=NONE
  hi TabLineSel           guifg=White guibg=Black
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" enable mouse
set mouse=a

" set encoding=utf-8  " utf8 encoding
" set fileencodings=  " automatikus filefelismeres
set shiftwidth=2  " 2 space az autoindentnel
set showmatch     " zaro zarojelhez megmutatja a parjat
set nostartofline " ugrasoknal ne menjen a sor elejere

set foldmethod=marker " folding bekapcsolasa

set autoindent    " always set autoindenting on
set si            " smartindent

set nobackup      " keep no backup file

set history=50    " keep 50 lines of command line history
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set ic            " ignore case

set ls=2          " enable the status

set et            " expandt tab
set mousemodel=extend
set ch=2
set tabstop=2
set softtabstop=2
set smarttab
set textwidth=0
set so=5          " 5 lines of scope
set vb            " visual bell
set lz            " lazy redraw

" backup/swap to ~/backup first
set directory=~/backup,.,~/tmp,/var/tmp,/tmp
set backupdir=~/backup,.,~/tmp,/var/tmp,/tmp
" switch on backup
set bk

if has("gui_running")
  set nu
  set lines=40
  set columns=100
  set guioptions-=T
  set guioptions-=m
  set guioptions-=r
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=0

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

" minibuf explorer
"source ~/.vim/minibufexpl.vim

" gpg crypt/decrypt

augroup encrypted
  au!

  "nem ment a viminfoba, swp-be
  autocmd BufReadPre,FileReadPre      *.gpg,*.asc set viminfo=
  autocmd BufReadPre,FileReadPre      *.gpg,*.asc set noswapfile
  "olvasas: binrais
  autocmd BufReadPre,FileReadPre      *.gpg set bin
  "autocmd BufReadPre,FileReadPre      *.gpg,*.asc let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost    *.gpg,*.asc '[,']!sh -c 'gpg --decrypt 2> /dev/null'
  "iraskor normal mod
  autocmd BufReadPost,FileReadPost    *.gpg set nobin
  "autocmd BufReadPost,FileReadPost    *.gpg,*.asc let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost    *.gpg,*.asc execute ":doautocmd BufReadPost " . expand("%:r")
  "menteskor encrypt
  autocmd BufWritePre,FileWritePre    *.gpg '[,']!sh -c 'gpg --default-recipient-self -e 2>/dev/null'
  autocmd BufWritePre,FileWritePre    *.asc '[,']!sh -c 'gpg --default-recipient-self -ae 2>/dev/null'
  "undo encrypt
  autocmd BufWritePost,FileWritePost  *.gpg,*.asc u
augroup END

" python
function! RePa_py()
  set tw=0
  set sw=4
  set ts=4
  set sta
  set et
  set sts=4
  set ai
endfunction

au FileType python set tw=0
au FileType python set sw=4
au FileType python set ts=4
au FileType python set sta
au FileType python set sts=4
au FileType python set ai

" egergombok
imap <RightMouse> <Esc>
nmap <RightMouse> i<LeftMouse>

" egyeb gombok
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_

" 4 spaces fileok (python)
nmap <F5> :call RePa_py()<CR>

" funkciogombok
nmap <F7> :set list!<CR>
nmap <F8> :set wrap!<CR>
nmap <F9> :Tlist<CR>
nmap <F11> :set nu!<CR>
nmap <F12> :set list!<CR>

" tab navigation like firefox
nmap <F3> :tabprevious<cr>
nmap <F4> :tabnext<cr>
map <F3> :tabprevious<cr>
map <F4> :tabnext<cr>
imap <F3> <ESC>:tabprevious<cr>i
imap <F4> <ESC>:tabnext<cr>i
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>

" setting the status line

function! RePa_sl_lines()
  if &nu == 0
    return ''
  else
    let b:lastline = line('$')
    if b:lastline < 10
      return '[     '.b:lastline.'] '
    elseif b:lastline < 100
      return '[    '.b:lastline.'] '
    elseif b:lastline < 1000
      return '[   '.b:lastline.'] '
    elseif b:lastline < 10000
      return '[  '.b:lastline.'] '
    elseif b:lastline < 100000
      return '[ '.b:lastline.'] '
    elseif b:lastline < 1000000
      return '['.b:lastline.'] '
    else
      return b:lastline.' '
    endif
  endif
endfunction

function! RePa_sl_filestate()
  let state = ""
  
  if &buftype == "help"
    return 'H'
  elseif &buftype == "nowrite"
    return '-'
  elseif &modified != 0
    return '*'
  else
    return ' '
  endif
endfunction

function! RePa_sl_fileformat()
  if &fileformat == ""
    return "--"
  else
    return &fileformat
  endif
endfunction

function! RePa_sl_fileencoding()
  if &fileencoding == ""
    if &encoding != ""
      return &encoding
    else
      return "--"
    endif
  else
    return &fileencoding
  endif
endfunction

function! RePa_sl_filetype()
  if &filetype == ""
    return "--"
  else
    return &filetype
  endif
endfunction

function! RePa_sl_expandtabON()
  if &expandtab == 0
    return ""
  else
    return "notab"
  endif
endfunction

function! RePa_sl_expandtabOFF()
  if &expandtab == 0
    return "notab"
  else
    return ""
  endif
endfunction

function! RePa_sl_ignorecaseON()
  if &ignorecase == 0
    return ""
  else
    return "ic"
  endif
endfunction

function! RePa_sl_ignorecaseOFF()
  if &ignorecase == 0
    return "ic"
  else
    return ""
  endif
endfunction

function! RePa_sl_mode()
  return mode()
endfunction

function! RePa_statusline()

  let sl = ""
  
  " lines
  let sl = sl . '%2*%{RePa_sl_lines()}'
  " filename
  let sl = sl . '%1*%t'
  " filestate
  let sl = sl . '%3*%{RePa_sl_filestate()}\ '
  " break
  let sl = sl . '%<'
  " fileformat
  let sl = sl . '%2*[%{RePa_sl_fileformat()}:'
  " encoding
  let sl = sl . '%{RePa_sl_fileencoding()}:'
  " filetype
  let sl = sl . '%{RePa_sl_filetype()}]'

  " justify to right
  let sl = sl . '\ %='

  " expand tab
  let sl = sl . '%3*%{RePa_sl_expandtabON()}'
  let sl = sl . '%4*%{RePa_sl_expandtabOFF()}'
  
  " ignorecase
  let sl = sl . '%3*\|%{RePa_sl_ignorecaseON()}'
  let sl = sl . '%4*%{RePa_sl_ignorecaseOFF()}'
  
  " mode
  let sl = sl . '%2*\ [%3*%{RePa_sl_mode()}%2*]\ '
  
  " position, line and column, percentage
  let sl = sl . '%05(%l%),%03(%v%)%2*\ %P'
  
  return sl
  
endfunction

" set the statusline
execute "set statusline=" . RePa_statusline()

" taglist
let Tlist_Inc_Winwidth=0

