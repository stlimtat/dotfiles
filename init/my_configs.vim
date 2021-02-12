" solarized
set background=dark
colorscheme solarized

" Fast saving of a buffer
nmap <leader>w :w!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" When you press <leader>r you can search and replace the selected text:
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" insert current date and time
iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

" bufexplorer
map <leader>o :BufExplorer<cr>

" NERDtree
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>

