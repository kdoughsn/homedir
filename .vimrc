let &titlestring = hostname() . ":" . getcwd() . " (" . expand("%:t") . ") - VIM"

set wildmenu			" Enable file/command completion
set wildmode=list:longest	" Complete only up to the point of ambiguity
set nowrap
set showmatch
set hlsearch			" Highlight search terms
set incsearch			" Highlight search terms as you type them
set shiftwidth=8
set textwidth=0
set tabstop=8
set softtabstop=4
"set backspace=2
set backspace=indent,eol,start	" Make backspace delete lots of things
set title
set smarttab
set ignorecase			" Case insensitive searching
set smartcase			" Searches w/ capitals become sensitive
set sidescroll=1
set sidescrolloff=3
set scrolloff=3			" More context around the cursor
set hidden			" Multiple buffer management
set history=1000		" Keep longer history
set ruler			" Show the line/column/% in the bottom-right status
"set laststatus=2		" Always show filename (2 is always)
set shortmess=atI		" Shorten "Press ENTER or type command to continue" prompt
set nocompatible
set timeoutlen=300		" Quick timeouts on key combinations

runtime macros/matchit.vim	" Enable extended % matching


" Ctrl+e and Ctrl+y scroll the viewport by 3 lines instead of 1
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Filetype highlighting and configuration
filetype plugin indent on

" Catch trailing whitespace
"set listchars=tab:>-,trail:·,eol:$
"nmap <silent> <leader>s :set nolist!<CR>


"
" Syntax Highlighting
"
hi normal  ctermfg=white ctermbg=black guifg=white guibg=black
hi search  ctermfg=white ctermbg=red   guifg=white guibg=red
hi comment ctermbg=black ctermfg=cyan  guifg=white guibg=blue
syntax on
set background=dark


" Allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" File type overrides
"au BufNewFile,BufRead  svn-commit.* setf svn

" this means vim will always jump to the last edited line in a file if poss
autocmd BufEnter *,.* :normal '"
"autocmd BufNewFile,BufRead *.c,*.h,*.java,*.pl set ai
"autocmd BufNewFile  *.c                     0r ~/.vim/skeleton/skeleton.c
"autocmd BufNewFile  *.cpp,*.cxx,*.c++,*.cc  0r ~/.vim/skeleton/skeleton.cxx
"autocmd BufNewFile  *.h                     0r ~/.vim/skeleton/skeleton.h
"autocmd BufNewFile  *.java                  0r ~/.vim/skeleton/skeleton.java
"autocmd BufNewFile  *.pl                    0r ~/.vim/skeleton/skeleton.pl
"autocmd BufNewFile  *.html                  0r ~/.vim/skeleton/skeleton.html
"autocmd BufNewFile  *.php                   0r ~/.vim/skeleton/skeleton.php
"autocmd BufNewFile  *.sh                    0r ~/.vim/skeleton/skeleton.sh


autocmd BufNewFile *.c,*.cpp,*.cxx,*.c++,*.cc,*.h,*.java,*.pl,*.cgi,*.php ks|call NewFile()|'s
fun NewFile()
    exe "% s#__FILE_NAME__#File: " . expand("%")
    exe "% s#__FILE_NAME_ONLY__#" . expand("%:t:r")
    exe "% s#__DIR_NAME__#" . expand("%:p:h:t")
    exe "% g#__DATE_YEAR__#s#__DATE_YEAR__#" . strftime("%Y")
endfun


"
" Common Typos
"
command! Q  quit	" :Q  => :q
command! W  write	" :W  => :w
command! Wq wq		" :Wq => :wq

" -------------------
"  Utilities
" -------------------

" Reverse visually selected text
"    Select text and hit ;rv
vnoremap ;rv c<C-O>:set revins<cr><C-R>"<esc>:set norevins<cr>

" \fr: will reverse the order of lines (vertical mirror)
nmap \fr   :set lz<CR>o<Esc>mz'aO<Esc>ma:'a+1,'z-1g/^/m 'a<CR>'addma'zdd:set nolz<CR>

" \fR: will mirror image the lines (horizontal mirror)
nmap \fR   :set lz<CR>o<Esc>mzkO<Esc>maj:s/./&\r/g<CR>:'a+1,'z-1g/^/m 'a<CR>:'a+1,'z-1j!<CR>'add'zddk:set nolz<CR> 



"
" Commenting and Uncommenting in source files
"
" How to use:
"     ,c  comments out a region
"     ,u  uncomments a region
autocmd FileType sql                         let b:comment_leader = '--'
autocmd FileType vim                         let b:comment_leader = '"'
autocmd FileType c,cpp,java,php              let b:comment_leader = '//'
autocmd FileType perl,sh,make,bash,tcsh,ruby let b:comment_leader = '#'
autocmd FileType tex                         let b:comment_leader = '%'
autocmd FileType cfg                         let b:comment_leader = '#'
noremap <silent> ,c :<C-B>sil <C-E>s/^\(\s*\)/<C-R>=escape(b:comment_leader,'\/') <CR>\1/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\(\s*\)\V<C-R>=escape(b:comment_leader,'\/') <CR>/\1/e<CR>:noh<CR> 

" Prevent vim from adding a newline to the endofline (eol) to certain files (those that have been edited on windows)
"autocmd FileType php setlocal noeol binary


"
" Before and after pasting and autoindent via F5
"
nnoremap <F5> :set invpaste paste?<Enter>
imap <F5> <C-O><F5>
set pastetoggle=<F5>


" 
" Toggle show whitespace characters (e.g. se list) via F6
" 
" have \tl ("toggle list") toggle list on/off and report the change:
nnoremap \tl :set invlist list?<CR>
nmap <F6> \tl

"
" Toggle wrapping via F7
"
nnoremap \t2 :set invwrap wrap?<CR>
nmap <F7> \t2

"
" Disable parenthesis matchingnd highlighting
"
let loaded_matchparen = 1

if filereadable(glob("~/.vimrc.local")) 
	source ~/.vimrc.local
endif
