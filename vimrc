set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" 生成函数、变量列表
Plugin 'Tagbar'

" lisp
Plugin 'paredit.vim'
Plugin 'darvelo/vim-niji'
Plugin 'vim-scripts/VimClojure'

Plugin 'mileszs/ack.vim'
Plugin 'joonty/vdebug'

" 搜索目录下的文件
Plugin 'ctrlp.vim'

" 生成代码段，如：fo(){} (配合YouCompleteMe or neocomplcache)
Plugin 'UltiSnips'

Plugin 'sudo.vim'

" 关键字、文件路径、tag补全
Plugin 'neocomplcache'
let g:neocomplcache_enable_at_startup = 1

" 自动代码补全
"Plugin 'clang-complete'

" 根据tag高亮类、变量、函数和关键字
Plugin 'TagHighlight'

" 工程目录树
Plugin 'scrooloose/nerdtree'
" 方便浏览buffer
Plugin 'bufexplorer.zip'
" 让nerdTree在最后一个buffer窗口关闭时，不让其缩进
Plugin 'bufkill.vim'

" 生成成对的(), {}, []
Plugin 'delimitMate.vim'

Plugin 'ervandew/supertab'

" 保存文件时检查语法
"Plugin 'scrooloose/syntastic'
"Plugin 'tpope/vim-bundler'

Plugin 'plasticboy/vim-markdown'
" 状态增强显示
Plugin 'Lokaltog/vim-powerline'

" git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

Plugin 'comments.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'

let g:slimv_swank_cmd = '! xterm -e sbcl --load /usr/share/common-lisp/source/slime/start-swank.lisp &' 
" let g:slimv_swank_cmd = '! xterm -e clisp --load /usr/share/common-lisp/source/slime/start-swank.lisp &'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"-------------------------------------------------------------------------------------------

" 主题---------------start---------------
syntax enable
"set background=dark
"set background=light
"colorscheme solarized
"let g:solarized_termcolors=256
"set t_Co=256
" 主题----------------end----------------

" -----------折叠 start-----------------
set foldenable " 开始折叠
" 设置语法折叠
" manual  手工定义折叠
" indent  更多的缩进表示更高级别的折叠
" expr    用表达式来定义折叠
" syntax  用语法高亮来定义折叠
" diff    对没有更改的文本进行折叠
" marker  对文中的标志折叠
set foldmethod=indent " 设置语法折叠
" set foldmethod=syntax
" 折叠相关的快捷键
" zR 打开所有的折叠
" za Open/Close (toggle) a folded group of lines.
" zA Open a Closed fold or close and open fold recursively.
" zi 全部 展开/关闭 折叠
" zo 打开 (open) 在光标下的折叠
" zc 关闭 (close) 在光标下的折叠
" zC 循环关闭 (Close) 在光标下的所有折叠
" zM 关闭所有可折叠区域
set foldcolumn=0 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层数为
" 新建的文件，刚打开的文件不折叠
autocmd! BufNewFile,BufRead * setlocal nofoldenable
" set foldclose=all " 设置为自动关闭折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 用空格键来开关折叠
" ---------折叠end-----------------

" ctags
" nmap <C-F5> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
nmap <C-F5> :!ctags -R * .<CR>

" winmanager start
" 插入模式下 :WMToggle
let g:winManagerWindowLayout='FileExplorer|TagList'

"----------cscope start-----------
nmap <C-F6> :!cscope -Rbkq <CR>
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
	"add any database in current directly"
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	set csverb
endif

" cscope 快捷键：
"  先按: ctrl + @ 
"  然后快速按下： s/g/c/...
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" 操作指令
" 在源代码目录下输入：
" find . -name "*.[ch]" -o -name "*.cpp" -o -name "*.hpp" > cscope.file
" cscope -Rbkq / cscope -bkq -i cscope.file
"	-R: 生成索引文件时，搜索子目录树中的代码
"	-b: 只生成索引文件，不进入cscope的界面
"	-k: 不搜索/usr/include目录
"	-q: 生成cscope.in.out和cscope.po.out 文件，加快索引速度
"
" vim <file> #打开一个文件；
" :cs add cscope.out
" :cs find g <pattern> #搜索一个宏变量的定义位置；
"	s: 查找c代码符号
"	g: 查找本定义
"	d: 查找本函数调用的函数
"	c: 查找调用本函数的函数
"	t: 查找本字符串
"	e: 查找本egrep模式
"	f: 查找本文件
"	i: 查找包含本文件的文件
"-----------cscope end-----------------

"set relativenumber
"set number
"set cursorline
"set cursorcolumn
set ruler " 打开状态栏标尺
set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4 " 设定 tab 长度为 4
set nobackup " 覆盖文件时不备份
" set autochdir " 自动切换当前目录为当前文件所在的目录
set backupcopy=yes " 设置备份时的行为为覆盖
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan " 禁止在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果
set hlsearch " 搜索时高亮显示被找到的文本
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码
set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
set matchtime=1 " 短暂跳转到匹配括号的时间
set magic " 设置魔术
set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set guioptions-=T " 隐藏工具栏
set guioptions-=m " 隐藏菜单栏
set smartindent " 开启新行时使用智能自动缩进
set backspace=indent,eol,start
" 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1 " 设定命令行的行数为 1
set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
" set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\

