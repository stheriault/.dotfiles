" -------------------------------- General ---------------------------------{{{1

" Disable compatiblity with vi
set nocompatible

" disable error bells and visuals
set noerrorbells
set novisualbell

" Quickly time out on keycodes, but never time out on mappings
" set notimeout
set ttimeout
set ttimeoutlen=200

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" display white chars
set list
set listchars=tab:>-,trail:-,nbsp:%

" disable wrapping
set nowrap

" use the system clipboard when yanking or deleting
set clipboard=unnamed

" -------------------------------- Text Editing and Motion -----------------{{{1

" allow backspace/del over autoindent, line breaks, and start of insert action
set backspace=indent,eol,start

" toggle between 'paste' and 'nopaste', to disable odd effects when pasting text
set pastetoggle=<F11>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" add a blank line below the current
nmap <enter> o<esc>k

" split the line at the cursor position, opposite of Shift-J
nmap <C-J> i<CR><Esc>k$

" Insert-mode only CAPS LOCK (press ctrl-^ to initiate)
" define the mapping, a<->A, ...
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor

autocmd InsertLeave * set iminsert=0 " Disable capslock when leaving insert mode

" highlight all the trailing whitespace
command! ShowTrailingWhiteSpace /\s\+$
command! DeleteTrailingWhiteSpace :%s/\s\+$//

" remap the esc key
inoremap jk <ESC>

" remap a couple of other hard to reach keys
inoremap uu _
inoremap UU -
inoremap Uu =
inoremap uU =

"inoremap <A-u> <C-o>gUB

" -------------------------------- File Handling ---------------------------{{{1

" Hide buffer instead of unloading it when swapping buffers
set hidden

" raise dialog asking to confirm (eg, save), instead of failing
set confirm

" -------------------------------- User Interface --------------------------{{{1

" use a better commandline completion
set wildmenu

" set the command window height to avoid having to press <enter> to continue
set cmdheight=2

" show partial commands as they are typed
set showcmd

" show cursor position in the status line
set ruler

" show line numbers on the left
set number

" always display the status line, even if only one window is displayed
set laststatus=2

" Use the mouse for everything
set mouse=a

" make the mouse work past the 220th column
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

" -------------------------------- Searching -------------------------------{{{1

" highlight matches as a search command is typed
set incsearch

" highlight all matches of a search
set hlsearch

" make searching case insensitive unless there is a capital letter in the string
set ignorecase
set smartcase

" -------------------------------- Indentation and Spacing -----------------{{{1

" enable filetype-specific indentation
filetype indent on

" when opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the previous line
set autoindent

" Indentation settings for using 2 spaces instead of tabs.
set shiftwidth=2
set softtabstop=2
set expandtab

" -------------------------------- Colors and Fonts ------------------------{{{1

" enable syntax highlighting
syntax on

" colors
set background=dark

" Create a warning after 80 characters
execute "set colorcolumn=" . join(range(81,335), ',')
highlight ColorColumn ctermbg=234 guibg=#111111

" -------------------------------- Filetype-Specific Behavior --------------{{{1

" enable filetype-specific plugins
filetype plugin on

