""
"" Janus setup
""

" Define paths
let g:janus_path = escape(fnamemodify(resolve(expand("<sfile>:p")), ":h"), ' ')
let g:janus_vim_path = escape(fnamemodify(resolve(expand("<sfile>:p" . "vim")), ":h"), ' ')
let g:janus_custom_path = expand("~/.janus")

" Source janus's core
exe 'source ' . g:janus_vim_path . '/core/before/plugin/janus.vim'

" You should note that groups will be processed by Pathogen in reverse
" order they were added.
call janus#add_group("tools")
call janus#add_group("langs")
call janus#add_group("colors")

""
"" Customisations
set winwidth=84 
set winheight=5
set winminheight=5
set winheight=999
set number

"" switcher between paste and nonpaste mode 
set pastetoggle=<F10> 

"" cut/copy text in visual mode to the operating system clipboard 
vmap <C-x> :!pbcopy<CR>  
vmap <C-c> :w !pbcopy<CR><CR>

if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" Disable plugins prior to loading pathogen
exec 'source ' . g:janus_vim_path . '/core/plugins.vim'

" Load all groups, custom dir, and janus core
call janus#load_pathogen()

 .vimrc.after is loaded after the plugins have loaded
