" =======================================
" Vundle
" =======================================
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" instructions:
" Brief help
" :PluginList- lists configured plugins
" :PluginInstall- installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean- confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

Plugin 'VundleVim/Vundle.vim' " Manage plugins
Plugin 'scrooloose/nerdtree' " Project and file navigation
Plugin 'Xuyuanp/nerdtree-git-plugin' " NerdTree git functionality
Plugin 'ryanoasis/vim-devicons' " Dev Icons
Plugin 'vim-airline/vim-airline-themes' " Themes for airline
Plugin 'tpope/vim-surround'
Plugin 'flazz/vim-colorschemes' " Support for coloschemes
Plugin 'majutsushi/tagbar' " Class/module browser
Plugin 'vim-ctrlspace/vim-ctrlspace' " Tabs/Buffers/Fuzzy/Workspaces/Bookmarks
Plugin 'ervandew/supertab' " More functions for tabs
Plugin 'thaerkh/vim-indentguides' " Visual representation of indents
Plugin 'tpope/vim-commentary' " Support for multifunctionality in comments
Plugin 'bfrg/vim-cpp-modern' " Support for syntax highlighting for C/C++
Plugin 'mhinz/vim-startify' "When start only without specific file represents a beautiful ascii text ;-)
Plugin 'itchyny/lightline.vim'
Plugin 'Raimondi/delimitMate' " Automatic close of quotes, patenthesis, brackets, etc.
Plugin 'neoclide/coc.nvim' " Language completion support.
" Themes
Plugin 'connorholyday/vim-snazzy'
Plugin 'jsit/toast.vim'

" All of your Plugins must be added before the following line
call vundle#end() " required
