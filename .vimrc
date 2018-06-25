set tags=./tags,./TAGS,tags,TAGS,../tags
set autochdir
"防止中文乱码
set fileencoding=
set fileencodings=gb2312
"显示行号
set nu
"kernelnewbies上抄的
set title
"允许文件类型插件
filetype plugin indent on
"开启语法高亮
syntax on
"tab长度
set tabstop=2     "移动时的tab长度
set softtabstop=2	"输入的单个tab长度
set shiftwidth=2  "	
set noexpandtab
"set hlsearch
"添加一点东西
"显示未完成命令
set showcmd 
"tab变成>---,末尾空白字符变成-
"set listchars=tab:>-,trail:-
"忘了得先开启空白字符显示
"set list
"source ~/.vim/script/hello.vim
"所在行底光标,开了有些标点看不清,关了
"set cursorline
"set cursorbind
source ~/.vim/script/my.vim
set nocp 
"========================================================
"vundle用的
"========================================================
" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')

" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'
"=========================================================================
"--------------------------留点地方放插件--------------------------------
"=========================================================================
"
Plugin 'scrooloose/nerdtree'	"树
"Plugin 'valloric/youcompleteme' "用不起
Plugin 'kien/ctrlp.vim'		"模糊搜索文件??
Plugin 'tpope/vim-fugitive'	"git
Plugin 'mattn/emmet-vim'	"好像牛逼
"Plugin 'Shougo/neocomplcache.vim' "补全
Plugin 'terryma/vim-multiple-cursors' "多行光标编辑
Plugin 'tpope/vim-commentary'	"批量注释
Plugin 'molokai'		"主题
Plugin 'bling/vim-airline'	" 状态

"
"
"
"
"
"
"=========================================================================
"
"
" 以下范例用来支持不同格式的插件安装.
" 请将安装插件的命令放在vundle#begin和vundle#end之间.
" Github上的插件
" 格式为 Plugin '用户名/插件仓库名'
"Plugin 'tpope/vim-fugitive'
" 来自 http://vim-scripts.org/vim/scripts.html 的插件
" Plugin '插件名称' 实际上是 Plugin 'vim-scripts/插件仓库名' 只是此处的用户名可以省略
"Plugin 'L9'
" 由Git支持但不再github上的插件仓库 Plugin 'git clone 后面的地址'
"Plugin 'git://git.wincent.com/command-t.git'
" 本地的Git仓库(例如自己的插件) Plugin 'file:///+本地插件仓库绝对路径'
"Plugin 'file:///home/gmarik/path/to/plugin'
" 插件在仓库的子目录中.
" 正确指定路径用以设置runtimepath. 以下范例插件在sparkup/vim目录下
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" 安装L9，如果已经安装过这个插件，可利用以下格式避免命名冲突
"Plugin 'ascenator/L9', {'name': 'newL9'}

" 你的所有插件需要在下面这行之前
call vundle#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
" 忽视插件改变缩进,可以使用以下替代:
"filetype plugin on
"
" 简要帮助文档
" :PluginList       - 列出所有已配置的插件
" :PluginInstall    - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
"
" 查阅 :h vundle 获取更多细节和wiki以及FAQ
" 将你自己对非插件片段放在这行之后
"==========================================================================

