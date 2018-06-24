set number " 显示行号
set ruler " 显示标尺
set cursorline " 显示下划线
set laststatus=2 " 启动显示状态行(1),总是显示状态行(2)
set scrolloff=7 " 在上下移动光标时,光标的上方或下方至少会保留显示的行数
set ignorecase " 检索时忽略大小写
set smartcase " 如果输入模式包含大小写，不使用'ignorecase'选项
syntax on " 语法高亮
set langmenu=zh_CN.UTF-8
language messages zh_CN.UTF-8 " vim提示为中文
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Vundke------------------------------------------------------------------------------ set nocompatible " required 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限 Vundle必须
filetype off " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim'}
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/grep.vim'
Plugin 'vim-scripts/molokai'
call vundle#end() " required
filetype plugin indent on " required
"PluginList 展示插件列表
"PluginInstall 安装插件
"PluginSearch foo 搜索插件
"PluginClean 清除插件
" ------------------------------------------------------------------------------------

" nerdtree----------------------------------------------------------------------------
" 打开/关闭
noremap <F1> :NERDTreeMirror<CR>
noremap <F1> :NERDTreeToggle<CR>
" 当不带参数打开Vim时自动加载项目树
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 当所有文件关闭时关闭项目树窗格
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 不显示这些文件
let NERDTreeIgnore=['\.pyc$', '\~$', 'node_modules'] "ignore files in NERDTree
" 不显示项目树上额外的信息，例如帮助、提示什么的
let NERDTreeMinimalUI=1
" ------------------------------------------------------------------------------------

" ctrlp-------------------------------------------------------------------------------
let g:ctrlp_map = '<F2>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*/node_modules/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
	\'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
	\'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
	\}
" ctrl + j/k 进行上下选择
" ctrl + x 在当前窗口水平分屏打开文件
" ctrl + v 同上, 垂直分屏
" ctrl + t 在tab中打开
" ------------------------------------------------------------------------------------

" rainbow_parentheses.vim-------------------------------------------------------------
let g:rbpt_colorpairs = [
	\ ['brown',       'RoyalBlue3'],
	\ ['Darkblue',    'SeaGreen3'],
	\ ['darkgray',    'DarkOrchid3'],
     	\ ['darkgreen',   'firebrick3'],
      	\ ['darkcyan',    'RoyalBlue3'],
       	\ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
	\ ['brown',       'firebrick3'],
	\ ['gray',        'RoyalBlue3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['Darkblue',    'firebrick3'],
	\ ['darkgreen',   'RoyalBlue3'],
	\ ['darkcyan',    'SeaGreen3'],
	\ ['darkred',     'DarkOrchid3'],
	\ ['red',         'firebrick3'],
	\ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" -------------------------------------------------------------------------------------

" molokai------------------------------------------------------------------------------
colorscheme molokai
set t_Co=256
let g:molokai_original = 1
" -------------------------------------------------------------------------------------

nnoremap <C-]> g<C-]>

" syntastic----------------------------------------------------------------------------
let g:syntastic_error_symbol='XX'
let g:syntastic_warning_symbol='>>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
highlight SyntasticErrorSign guifg=white guibg=black
" to see error location list
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
function! ToggleErrors()
	let old_last_winnr = winnr('$')
	lclose
	if old_last_winnr == winnr('$')
		" Nothing was closed, open syntastic error location panel
		Errors
	endif
endfunction
"noremap <F3> :call ToggleErrors()<cr>
"nnoremap <F3>n :lnext<cr>
"nnoremap <F3>p :lprevious<cr>
" -------------------------------------------------------------------------------------

" powerline----------------------------------------------------------------------------
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
" -------------------------------------------------------------------------------------

" taglist------------------------------------------------------------------------------
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Use_Right_Window = 1 " taglist窗口出现在vim的右边
let Tlist_Exit_OnlyWindow = 1 " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Show_One_File = 1 " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Process_File_Always = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Auto_Update = 1
noremap <F4> :TlistToggle<CR>
" -------------------------------------------------------------------------------------

" vimgrep--------------------------------------------------------------------------------
nnoremap <silent> f :Rgrep<CR>
let Grep_Default_Filelist = '*.lua *.c *.cpp *.h *.xml *.py'
map f :Rgrep  \b<cword>\b<CR><CR><CR>
"-----------------------------------------------------------------------------------------

