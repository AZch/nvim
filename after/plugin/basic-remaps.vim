nnoremap <silent><space>w :w<CR>
nnoremap <silent><space>q :q<CR>

nmap <silent> <space>s <Plug>SearchNormal
vmap <silent> <space>s <Plug>SearchVisual

nmap <silent> <space>gy :Goyo<CR>

nmap <silent> <space>gl :diffget //3<CR>
nmap <silent> <space>gh :diffget //2<CR>

nnoremap c* *Ncgn

command EF :!npx eslint --fix %

command DV :DiffviewOpen
command DVF :DiffviewFileHistory
command DVM :DiffviewOpen origin/master...HEAD
command DVD :DiffviewOpen origin/development...HEAD

command -nargs=1 BS :BrowserSearch <args>
let g:browser_search_default_engine='duckduckgo'
nmap <space>bs :BS 

nnoremap <silent> <space><Tab> :bd<CR>

" Theme
filetype plugin on
syntax on

" Git
command! G :Gtabedit :
command GB :GBranches
command GC :Commits

nnoremap <silent> <space>gs    :G<CR>

if exists('g:loaded_webdevicons')                             
  call webdevicons#refresh()                                  
endif      

" Resizing
nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(10)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(-10)<CR>

let g:animate#duration = 100.0

" Airline
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:airline_powerline_fonts = 1 

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


nnoremap <silent><space>f :CHADopen<CR>
