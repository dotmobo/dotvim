"Vim configuration file

"load pathogen
execute pathogen#infect()

"Nerdtree on CTRL+N
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"no vi compatibility
set nocompatible

" load indent plugin
if has("autocmd")
 filetype plugin on
 filetype plugin indent on
endif

" syntax options
syntax on
set hlsearch
set incsearch
set ignorecase
set showmatch
set noswapfile
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set backspace=indent,eol,start
set history=100
set ruler
set showcmd
set number
set nospell
colorscheme delek

"new tab on CTRL+T
map <C-t> :tabnew<CR>

"Completion javascript
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"Completion html
au FileType html set omnifunc=htmlcomplete#CompleteTags
"Completion css
au FileType css set omnifunc=csscomplete#CompleteCSS

"Completion python with specific syntax
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(
set omnifunc=pythoncomplete#Complete

"Completion on ctrl+space
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Remove all blank on all end line
"autocmd BufWrite *.py silent! %s/[\r \t]\+$//

" lauch pyton script with F5
map <buffer> <F5> :w<CR>:!/usr/bin/env python % <CR>

" Django completion
function! SetAutoDjangoCompletion()
    let l:tmpPath = split($PWD, '/')
    let l:djangoVar = tmpPath[len(tmpPath)-1].'.settings'
    let $DJANGO_SETTINGS_MODULE=djangoVar
    echo 'Activation de la complétion Django avec : '.djangoVar
        return 1
endfunction
map <F9> :call SetAutoDjangoCompletion()<CR>


" Virtual env library completion
py << EOF
import os.path
import sys
import vim

if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" template for new python file
autocmd BufNewFile *.py,*.pyw 0read ~/.vim/templates/python.txt

