set encoding=utf-8

let mapleader = ','
nnoremap <Leader><Leader> :bnext<CR>
nnoremap ;; :bprevious<CR>

set backspace=indent,eol,start

" Chargement de Pathogen
call pathogen#infect()

" Activation de l'indentation automatique
set autoindent

" Redéfinition des tabulations
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8
set scrolloff=999
set wildmenu

" Activation de la détection automatique du type de fichier
filetype on
filetype plugin indent on

" Longueur maximale des lignes
" Pour Python
autocmd Filetype python set textwidth=79
autocmd Filetype python set cc=+1
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" Pour html
autocmd Filetype html set textwidth=79

" Activation de la coloration syntaxique
syntax on
set t_Co=256
let g:airline_powerline_fonts=1
let g:loaded_autocomplete=1
colorscheme delek

" Activation de la complétion 
" pour les fichiers python
au Filetype python set omnifunc=pythoncomplete#Complete
" pour les fichiers javascript
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" pour les fichiers html
au FileType html set omnifunc=htmlcomplete#CompleteTags
" pour les fichiers css
au FileType css set omnifunc=csscomplete#CompleteCSS

" Définition du type de complétion de SuperTab
" let g:SuperTabDefaultCompletionType = "context"

" Activation de la visualisation de la documentation
set completeopt=menuone,longest,preview

" Activation de la complétion pour Django
function! SetAutoDjangoCompletion()
    let l:tmpPath = split($PWD, '/')
    let l:djangoVar = tmpPath[len(tmpPath)-1].'.settings'
    let $DJANGO_SETTINGS_MODULE=djangoVar
    echo 'Activation de la complétion Django avec : '.djangoVar
    return 1
endfunction

" Activation de la complétion pour les librairies installées dans un virtualenv
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

" Exécution des tests unitaires
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>

" Activation de la barre de statut de fugitive
set laststatus=2

" pep8
let g:pep8_map='whatever'

" Fonction d'affichage d'un message en inverse vidéo
function! s:DisplayStatus(msg)
    echohl Todo
    echo a:msg
    echohl None
endfunction

" Variable d'enregistrement de l'état de la gestion de la souris
let s:mouseActivation = 1

" Fonction permettant l'activation/désactivation de la gestion de la souris
function! ToggleMouseActivation()
    if (s:mouseActivation)
        let s:mouseActivation = 0
        set mouse=c
        set paste
        call s:DisplayStatus('Désactivation de la gestion de la souris (mode collage)')
    else
        let s:mouseActivation = 1
        set mouse=a
        set nopaste
        call s:DisplayStatus('Activation de la gestion de la souris (mode normal)')
    endif
endfunction

" Activation par défaut au démarrage de la gestion de la souris
set mouse=a
set nopaste

" Fonction de nettoyage d'un fichier :
"   - remplacement des tabulations par des espaces
"   - suppresion des caractères ^M en fin de ligne
function! CleanCode()
    %retab
    %s/^M//g
    call s:DisplayStatus('Code nettoyé')
endfunction

" Affichage des numéros de ligne
set number
" highlight LineNr ctermbg=blue ctermfg=gray

" Surligne la colonne du dernier caractère autorisé par textwidth
set cc=+1
highlight colorcolumn ctermbg=darkblue

" Amélioration de la recherche avant et arrière avec surlignement du pattern
map * <Esc>:exe '2match Search /' . expand('<cWORD>') . '/'<CR><Esc>:exe '/' . expand('<cWORD>') . '/'<CR>
map ù <Esc>:exe '2match Search /' . expand('<cWORD>') . '/'<CR><Esc>:exe '?' . expand('<cWORD>') . '?'<CR>


"Nerdtree on CTRL+N
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"new tab on CTRL+T
map <C-t> :tabnew<CR>

" gui font
if has('gui_running')
    set guifont=Monospace\ 12
    colorscheme desert
endif


" template for new python file
autocmd BufNewFile *.py,*.pyw 0read ~/.vim/templates/python.txt


" Affichage et masquage de la fenêtre Taglist
map <F8> <Esc>:TlistToggle<CR> 

" Activation de la complétion Django
map <F10> <Esc>:call SetAutoDjangoCompletion()<CR>

" Activation de l'historique des modifications
map <C-h> <Esc>:GundoToggle<CR>

" Appel de la fonction d'activation/désactivation de la souris
map <F4> <Esc>:call ToggleMouseActivation()<CR>

" Appel de la fonction de nettoyage d'un fichier (enlève les ^M parasites en
" fin de ligne
map <F3> <Esc>:call CleanCode()<CR>
imap <F3> <Esc>:call CleanCode()<CR>i

