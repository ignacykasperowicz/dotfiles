let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" This is the personal .vimrc file of Adam Okoń
" based on .vimrc file of Steve Francia (http://spf13.com)
" and Daniel Stokowiec.
" }

" Setup Bundle Support {
" The next two lines ensure that the ~/.vim/bundle/ system works
	runtime! autoload/pathogen.vim
    silent! call pathogen#runtime_append_all_bundles()
    execute pathogen#infect()
" }

" Plugins {
    call plug#begin('~/.vim/plugged')

    Plug 'janko-m/vim-test'
    Plug 'rizzatti/dash.vim'
    Plug 'osyo-manga/vim-over'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'rust-lang/rust.vim'
    Plug 'benmills/vimux'

    call plug#end()
" }

" Basics {
	set nocompatible                                        " must be first line
	set hidden                                              " buffer becomes hidden when it is abandoned
    set relativenumber
    "set shortmess=a
    "set cmdheight=2
" }


" General {
	syntax on 					                            " syntax highlighting
	scriptencoding utf-8
    filetype off
	filetype plugin indent on                               " Automatically detect file types.

	set history=100                                         " how many lines of history to remember
	set mouse=a					                            " automatically enable mouse usage
	set noerrorbells                                        " don't make noise on error messages
	set novisualbell                                        " don't blink
	set autowrite
    autocmd BufWritePre * :%s/\s\+$//e

	" Setting up the directories {
		"set backup 					                    " backups are nice ...
        set backupdir=$HOME/.vimbackup                      " but not when they clog .
        set directory=$HOME/.vimswap 	                    " Same for swap files

		" Creating directories if they don't exist
        silent execute '!mkdir -p $HOME/.vimbackup'
        silent execute '!mkdir -p $HOME/.vimswap'

        set nobackup
        set noswapfile
	" }
" }

" Vim UI {
	color Tomorrow-Night                                    " load a colorscheme, for gvim in GUI settings
  set background=dark                                     " Assume a dark background
	set cursorline  		                                " highlight current line
	set showmode               	                            " display the current mode

	if has('cmdline_info')
		set ruler                  	                        " show the ruler
		set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)  " a ruler on steroids
		set showcmd                	                        " show partial commands in status line and
									                        " selected characters/lines in visual mode
	endif

	set lazyredraw                                          " do not redraw while running macros (much faster) (LazyRedraw)
	set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$ " what to show when I hit :set list

	set backspace=indent,eol,start 	                        " make backspace work normal (indent, eol, start)
	set linespace=0					                        " could be < 0
	set number 						                        " Line numbers on
	set showmatch          	                                " show matching brackets/parenthesis
	set incsearch 					                        " find as you type search
	set hlsearch 					                        " highlight search terms
	set winminheight=0 			                            " windows can be 0 line high
	set ignorecase 					                        " case insensitive search
	set smartcase 					                        " case sensitive when uc present
	set wildmenu 					                        " show list instead of just completing
	set wildmode=list:longest,full 	                        " comand <Tab> completion, list matches, then longest common part, then all.
	set whichwrap+=<,>,[,]                                  " allow backspace and cursor keys to cross line boundaries
	set scrolljump=0 				                        " lines to scroll when cursor leaves screen
	set scrolloff=5 				                        " minimum lines to keep above and below cursor
	set foldenable  				                        " auto fold code
	set gdefault					                        " the /g flag on :s substitutions by default
  let g:airline#extensions#tabline#enabled = 0
  let g:airline#extensions#tabline#show_splits = 0
" }


" Formatting {
	set wrap                " wrap long lines
	set autoindent          " indent at the same level of the previous line
	set smartindent         " smart autoindenting for C programs
	set shiftwidth=2       	" use indents of 2 spaces
	set expandtab 	       	" dont use tabs
	set tabstop=2 			" an indentation every four columns
	set softtabstop=2
    set colorcolumn=120
	set nosmarttab

	"set matchpairs+=<:>             " match, to be used with %
	set pastetoggle=<F12>          	 " pastetoggle (sane indentation on pastes)
	"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
	set formatoptions+=n

  autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd BufNewFile,BufRead *.less set filetype=less
  autocmd BufNewFile,BufRead *.phtml set filetype=php
  autocmd BufNewFile,BufRead Capfile set filetype=ruby
  autocmd BufNewFile,BufRead *.es6 setfiletype javascript
" }


" Highlight whitespaces {
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
" }

" Folding {
	" set foldenable        " Turn on folding
	" set foldmethod=syntax " Make folding 'indent' sensitive or not
	" set foldlevel=100     " Don't autofold anything (but I can still fold manually)
	" set foldopen-=undo    " don't open folds when you undo stuff
" }

" Key Mappings {
	" Easier moving in tabs and windows
    let mapleader=","
	map <C-J> <C-W>j<C-W>
	map <C-K> <C-W>k<C-W>
	map <C-L> <C-W>l<C-W>
	map <C-H> <C-W>h<C-W>

  " Wrapped lines goes down/up to next row, rather than next line in file.
  noremap j gj
  noremap k gk

  " Fast saving
  nmap <leader>w :w<cr>

  nnoremap p ]p
  nnoremap <c-p> p

  " Run ag
  nmap <leader>a <Esc>:Ag!

  " Tests
  nmap <silent> <leader>j :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>A :TestSuite<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>

  noremap % v%
  nmap <silent> <leader>d <Plug>DashSearch
" }

" Plugins {
  "

  " YouCompleteMe {
     let g:ycm_collect_identifiers_from_tags_files = 1
     let g:ycm_collect_identifiers_from_comments_and_strings = 1
  " }

   " Ctags {
      set tags=./tags;/,~/.vimtags
      let Tlist_Enable_Fold_Column = 0 " Do not show folding tree
      let Tlist_Show_Menu = 1
      let Tlist_WinWidth = 40          " 40 cols wide, so i can (almost always) read my functions
      let Tlist_Use_Right_Window = 1

      map <leader>t :TlistToggle<CR>

    " }

    " YankRing {
		let g:yankring_history_dir = expand('$HOME') . '/.vimswap'
	" }

    " Delimitmate {
		au FileType * let b:delimitMate_autoclose = 1
		" If using html auto complete (complete closing tag)
        au FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"
	" }

	" AutoCloseTag {
		" Make it so AutoCloseTag works for xml and xhtml files as well
		au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
	" }

    " ctrlp {
        "let g:ctrlp_working_path_mode = 'ra'
        "nnoremap <silent> <leader>s :CtrlP<CR>
        "set wildignore+=*/tmp/*
        "set wildignore+=*/bower_components/*
        "set wildignore+=*/node_modules/*
        "let g:ctrlp_custom_ignore = {
                        "\ 'dir': '\.git$\|\.hg$\|\.svn$',
                        "\ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
    "}

    " fzf {
        let g:fzf_layout = { 'down': '~40%' }
        nnoremap <silent> <leader>s :FZF<CR>
    "}

    " vim-test {
        let test#strategy = "vimux"
        let test#ruby#rspec#executable = 'bundle exec rspec'
    " }

    " NerdTree {
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeMouseMode=2
        let NERDTreeKeepTreeInNewTab=1
    " }

    " Syntastic {
        "set statusline+=%#warningmsg#
        "set statusline+=%{SyntasticStatuslineFlag()}
        "set statusline+=%*

        "let g:syntastic_always_populate_loc_list = 1
        "let g:syntastic_auto_loc_list = 1
        "let g:syntastic_check_on_open = 1
        "let g:syntastic_check_on_wq = 0
        "let g:syntastic_ruby_checkers = ['rubocop']
    " }

" }

set runtimepath^=~/.vim/bundle/ag
