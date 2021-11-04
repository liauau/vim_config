set nu
set tabstop=4
"colorscheme desert

" Jeff's cscope settings:
" https://www.fsl.cs.sunysb.edu/~rick/cscope.html#:~:text=cscope%2C%20ctags%2C%20and%20Vim%20are%20powerful%20tools%20for,function%20calls%2C%20all%20variable%20uses%2C%20all%20macro%20uses%29.
" https://www.fsl.cs.sunysb.edu/~rick/rick_vimrc
if has("cscope")
	set csprg=/usr/bin/cscope
	" change this to 1 to search ctags DBs first
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
	    cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
	    cs add $CSCOPE_DB
	endif
	set csverb

	" Using 'CTRL-\' then a search type makes the vim window
	" "shell-out", with search results displayed on the bottom

	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

	" Using 'CTRL-spacebar' then a search type makes the vim window
	" split horizontally, with search result displayed in
	" the new window.

	nmap <C-[>s :scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[>g :scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[>c :scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[>t :scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[>e :scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-[>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-[>d :scs find d <C-R>=expand("<cword>")<CR><CR>

	" Hitting CTRL-space *twice* before the search type does a vertical
	" split instead of a horizontal one

	nmap <C-[><C-[>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[><C-[>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[><C-[>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[><C-[>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[><C-[>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-[><C-[>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-[><C-[>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif

map <F5> :call CompileRunUosX86()<CR>
imap <F5> <Esc>:call CompileRunUosX86()<CR>
vmap <F5> <Esc>:call CompileRunUosX86()<CR>
map <F4> :call CompileRunUosArm()<CR>
imap <F4> <Esc>:call CompileRunUosArm()<CR>
vmap <F4> <Esc>:call CompileRunUosArm()<CR>

map <F6> :call CompileRun()<CR>
imap <F6> <Esc>:call CompileRun()<CR>
vmap <F6> <Esc>:call CompileRun()<CR>

func! CompileRunUosX86()
exec "w"
if (&filetype == 'c') || (expand("%:e") == 'h')
    exec "!pushd; cd /home/liauau/Workshop/chassis; catkin_make -DARM=0 install; popd"
endif
endfunc

func! CompileRunUosArm()
exec "w"
if (&filetype == 'c') || (expand("%:e") == 'h')
    exec "!pushd; cd /home/liauau/Workshop/chassis; catkin_make -DARM=1 install; popd"
endif
endfunc

func! CompileRun()
exec "w"
if &filetype == 'c'
    exec "!gcc % -o %<"
    exec "!time ./%<"
elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %"
elseif &filetype == 'sh'
    exec "!time bash %"
elseif &filetype == 'python'
    exec "!time python3 %"
elseif &filetype == 'html'
    exec "!google-chrome % &"
elseif &filetype == 'go'
    exec "!go build %<"
    exec "!time go run %"
elseif &filetype == 'matlab'
    exec "!time octave %"
endif
endfunc
