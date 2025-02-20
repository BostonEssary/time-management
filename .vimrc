" Enable system clipboard integration
set clipboard=unnamedplus

" If you're using Neovim, uncomment these lines:
" let g:clipboard = {
"           \   'name': 'win32yank',
"           \   'copy': {
"           \      '+': 'win32yank.exe -i',
"           \      '*': 'win32yank.exe -i',
"           \    },
"           \   'paste': {
"           \      '+': 'win32yank.exe -o',
"           \      '*': 'win32yank.exe -o',
"           \   },
"           \   'cache_enabled': 1,
"           \ }

" Make Y behave like D and C (yank to end of line)
nnoremap Y y$

" Keep cursor position when yanking
vnoremap y myy`y
vnoremap Y myY`y

" Auto-format ERB files on save
augroup ERBFormat
  autocmd!
  autocmd BufWritePre *.erb :%!bundle exec htmlbeautifier
augroup END

" Format current buffer with ERB Lint
command! ERBLint !bundle exec erblint --autocorrect %

" General editing settings
set expandtab       " Use spaces instead of tabs
set tabstop=2      " Number of spaces for a tab
set shiftwidth=2   " Number of spaces for auto-indent
set softtabstop=2  " Number of spaces for a tab in insert mode
set autoindent     " Copy indent from current line when starting a new line 