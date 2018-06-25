autocmd BufNewFile *.c exec ":call s:setTitle()"
func s:setTitle()
	if &filetype == 'c'
		call setline(1,"/***************************************************************************")
		call append(line("."),"	>Filename: ".expand("%"))
		call append(line(".")+1,"	>Auther: jakio6")
		call append(line(".")+2,"	>Mail: jakio6@qq.com")
		call append(line(".")+3,"	>Created Time: ".strftime("%c"))
		call append(line(".")+4,"***************************************************************************/")
		call append(line(".")+5,"")
	endif
	if &filetype == 'c'
		call append(line(".")+6,"#include<stdio.h>")
		call append(line(".")+7,"")
	endif
"	exec "$"
	normal G
endfunc
"map <F4> :call s:dosth()<cr>
"function s:dosth()
func Settab()
exec	":set tabstop=4"
exec	":set softtabstop=4"
exec	":set shiftwidth=4"
endfunc

"endfun
"set softtabstop=4

"if $filetype == 'html'
"exec	":call Settab()"
"endif
"给我个理由为什么

func! Action()
	exec "wa"
	if &filetype == 'c'
		exec "!gcc % -o %<"
		exec "! ./%<"
	endif
	if &filetype == 'html'
		exec "!firefox %"
	endif
endfunc

 

map <F5> :call Action()<CR>
map <F12> :tabe ~/.vimrc<cr>
"map <F6> :tabe test.html<cr>
"map <F7> :source $MYVIMRC<cr>
":inoremap ( ()<ESC>i
":inoremap { {<CR>}<ESC>O
":inoremap [ []<ESC>i
":inoremap " ""<ESC>i
":inoremap ' ''<ESC>i

"====================================================================
"----------------------leader map----------------------------------
let mapleader="\\"
noremap <leader>s :w<cr>
"------------------------窗口移动 -----------------------------------------
nnoremap <leader><left> <c-w>h
nnoremap <leader><right> <c-w>l
nnoremap <leader><up> <c-w>j
nnoremap <leader><down> <c-w>k
"------------------------------------------------------------------
"nnoremap <leader>f :tab normal gf
nnoremap <leader>n :NERDTree<cr>
nnoremap <leader><tab> gt
inoremap jk <esc>
