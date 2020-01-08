**Configuración de [VIM](https://www.vim.org/)**

Esta configuración cuenta con lo siguiente:

**Plugins:**

1. [Vundle:](https://github.com/VundleVim/Vundle.vim) Administración de los plugins ;-)
2. [NerdTREE:](https://github.com/preservim/nerdtree) Administración de los árboles de trabajo.
3. [nerdtree-git-plugin:](https://github.com/Xuyuanp/nerdtree-git-plugin) Funcionalidad git a NerdTREE
4. [Dev-Icons:](https://github.com/ryanoasis/vim-devicons) Íconos para archivos fuente, carpetas, etc.
5. [vim-airline-themes:](https://github.com/vim-airline/vim-airline-themes) Tema airline.
6. [vim-surround:](https://github.com/tpope/vim-surround) Funcionalidad al abrir paréntesis, corchetes, llaves, etc.
7. [vim-colorschemes:](https://github.com/flazz/vim-colorschemes) Soporte para esquemas de colores.
8. [tagbar:](https://github.com/majutsushi/tagbar) Barra lateral para administrar la estructura del archivo 
que se esté editando.
9. [vim-ctrlspace:](https://github.com/vim-ctrlspace/vim-ctrlspace) Administración de pestañas, búferes, archivos, entre otros.
10. [ack.vim:](https://github.com/mileszs/ack.vim) Búsquedas
11. [FixedTaskList.vim:](https://github.com/fisadev/FixedTaskList.vim) Basado en la lista de tareas de Eclipse. 
Busca archivos que tengan tareas pendientes.
12. [supertab:](https://github.com/ervandew/supertab) Ofrece un mejor soporte para el completado con la clave: ```<TAB>```.
13. [vim-indentguides:](https://github.com/thaerkh/vim-indentguides) Ofrece una representación visual de los 
espacios de indentación.
14. [vim-commentary:](https://github.com/tpope/vim-commentary) Ofrece una mayor funcionalidad 
(que la que trae por defecto) al momento de realizar comentarios.
15. [rust.vim:](https://github.com/rust-lang/rust.vim) Soporte para el lenguaje de programación Rust
16. [vim-startify:](https://github.com/mhinz/vim-startify) Su repositorio lo cataloga como: 
**The fancy start screen for vim.** (Nada que agregar ;-).
17. [lightline.vim:](https://github.com/itchyny/lightline.vim) Barra de estado de estado ligera y personalizable.

**Temas:**

1. [Ayu:](https://github.com/ayu-theme/ayu-vim) Para la sintaxis en general (Se puede cambiar)
2. [vim-snazzy:](https://github.com/connorholyday/vim-snazzy) Para la barra de estado (Se puede cambiar)

**Algunas características de "mapeo"**

1. Utilizando ```gcc``` comentas una línea.
2. En modo visual, con unas líneas seleccionadas, utilizando ```gc``` las comentas todas.
3. Utilizando ```gcu``` descomentas una línea (El comando ```gcc``` también produce esto cuando está comentada).
4. En modo visual, con unas líneas (que están comentadas) seleccionadas, presionando (nuevamente) ```gc``` las descomentas.
5. Con ```<F3>``` abres NerdTREE que está oculto por defecto.
6. Para un "guardado rápido", además de ```:w``` puedes utilizar ```,w```

**Otras características a destacar:**

1. Espaciado e indentado: 8 espacios
2. Sin transparencia
3. Soporte para Rust, C/C++ y Python (Quizás le agregue más en el futuro, tampoco quisiera hacerlo demasiado "pesado").
4. Utiliza codificación UTF-8

**Instalación:**

```
$ wget https://raw.githubusercontent.com/brookiestein/dotfiles/master/vim/vimrc
$ git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim/
$ mv vimrc ~/.vim/
$ vim +PluginInstall! +qa!
```
Tengo pensado, para el futuro, agregar nuevas características a esta configuración.

Si desea tener las últimas características que se agreguen a esta configuración, repita el
proceso de instalación, omitiendo el segundo comando.
