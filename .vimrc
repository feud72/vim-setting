set nocompatible 
filetype off 
call plug#begin('~/.vim/plugged')

" Productivity
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/mru.vim'

" Vim library
Plug 'ascenator/L9', {'name': 'newL9'}

" Appearance
Plug 'nanotech/jellybeans.vim'
Plug 'https://github.com/itchyny/lightline.vim'

" HTML, CSS
Plug 'mattn/emmet-vim'
Plug 'https://github.com/skammer/vim-css-color'

" JavaScript, TypeScript
Plug 'prettier/vim-prettier', { 'do': 'yarn install'}
Plug 'neomake/neomake'
Plug 'leafgarland/typescript-vim'

"Python
Plug 'nvie/vim-flake8'
Plug 'psf/black'

"Autocompletion, Snippets
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
"Plug 'honza/vim-snippets'

"Go
Plug 'nsf/gocode', {'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'fatih/vim-go', {'tag': '*'}

call plug#end()
filetype plugin indent on

" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
map <C-n> <ESC>:NERDTree<CR>
map <C-p> <ESC>:MRU<CR>
syntax enable

set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set nu


"Javascript setting

let g:neomake_javascript_enabled_makers = ['eslint']
"let g:prettier#config#parser = 'babylon'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
call neomake#configure#automake('nrwi', 500)


"Python setting

let g:flake8_show_in_file=1
let g:flake8_max_markers=500
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePost *.py call flake8#Flake8()

"Go setting
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')


"Coc.nvim setting 
" if hidden is not set, TextEdit might fail. 
set hidden 
" Some servers have issues with backup files, see #649 
set nobackup 
set nowritebackup 
" Better display for messages 
set cmdheight=2 
" You will have bad experience for diagnostic messages when it's default 4000. 
set updatetime=300 
" don't give |ins-completion-menu| messages. 
set shortmess+=c 
" always show signcolumns 
set signcolumn=yes 
" Use tab for trigger completion with characters ahead and navigate. 
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin. 
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) : <SID>check_back_space() ? "\<TAB>" : coc#refresh() 
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>" 
function! s:check_back_space() abort 
	let col = col('.') - 1 
	return !col || getline('.')[col - 1] =~# '\s' 
endfunction 
let g:coc_snippet_next = '<TAB>'

" Use <c-space> to trigger completion. 
inoremap <silent><expr> <c-space> coc#refresh() 
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position. 
" Coc only does snippet and additional edit on confirm. 
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>" 
" Or use `complete_info` if your vim support it, like: 
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>" 

" Use `[g` and `]g` to navigate diagnostics 
nmap <silent> [g <Plug>(coc-diagnostic-prev) 
nmap <silent> ]g <Plug>(coc-diagnostic-next) 

" Remap keys for gotos 
nmap <silent> gd <Plug>(coc-definition) 
nmap <silent> gy <Plug>(coc-type-definition) 
nmap <silent> gi <Plug>(coc-implementation) 
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window 
nnoremap <silent> K :call <SID>show_documentation()<CR> 
function! s:show_documentation() 
	if (index(['vim','help'], &filetype) >= 0) 
		execute 'h '.expand('<cword>') 
	else 
		call CocAction('doHover') 
	endif 
endfunction 
" Highlight symbol under cursor on CursorHold 
autocmd CursorHold * silent call CocActionAsync('highlight') 
" Remap for rename current word 
nmap <leader>rn <Plug>(coc-rename) 
" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected) 
nmap <leader>f <Plug>(coc-format-selected) 

augroup mygroup 
	autocmd! 
	" Setup formatexpr specified filetype(s). 
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected') 
	" Update signature help on jump placeholder 
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp') 
augroup end 

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph 
xmap <leader>a <Plug>(coc-codeaction-selected) 
nmap <leader>a <Plug>(coc-codeaction-selected) 

" Remap for do codeAction of current line 
nmap <leader>ac <Plug>(coc-codeaction) 
" Fix autofix problem of current line 
nmap <leader>qf <Plug>(coc-fix-current) 

" Create mappings for function text object, requires document symbols feature of languageserver. 
xmap if <Plug>(coc-funcobj-i) 
xmap af <Plug>(coc-funcobj-a) 
omap if <Plug>(coc-funcobj-i) 
omap af <Plug>(coc-funcobj-a) 

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python 
nmap <silent> <C-d> <Plug>(coc-range-select) 
xmap <silent> <C-d> <Plug>(coc-range-select) 

" Use `:Format` to format current buffer 
command! -nargs=0 Format :call CocAction('format') 

" Use `:Fold` to fold current buffer 
command! -nargs=? Fold :call CocAction('fold', <f-args>) 

" use `:OR` for organize import of current buffer 
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport') 

" Add status line support, for integration with other plugin, checkout `:h coc-status` 
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')} 

" Using CocList 
" Show all diagnostics 
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr> 
" Manage extensions 
nnoremap <silent> <space>e :<C-u>CocList extensions<cr> 
" Show commands 
nnoremap <silent> <space>c :<C-u>CocList commands<cr> 
" Find symbol of current document 
nnoremap <silent> <space>o :<C-u>CocList outline<cr> 
" Search workspace symbols 
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr> 
" Do default action for next item. 
nnoremap <silent> <space>j :<C-u>CocNext<CR> 
" Do default action for previous item. 
nnoremap <silent> <space>k :<C-u>CocPrev<CR> 
" Resume latest coc list 
nnoremap <silent> <space>p :<C-u>CocListResume<CR>
