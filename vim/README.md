**Configuración de VIM**

Esta configuración cuenta con lo siguiente:

**Plugins:**

1. vundle: Administración de los plugins ;-)
2. nerdtree: Administración de los árboles de trabajo.
3. nerdtree-git-plugin: Funcionalidad git a NerdTREE
4. dev icons: Íconos para archivos fuente, carpetas, etc.
5. vim-airline-themes: Tema airline.
6. vim-surround: Funcionalidad al abrir paréntesis, corchetes, llaves, etc.
7. vim-colorschemes: Soporte para esquemas de colores.
8. tagbar: Barra lateral para administrar la estructura del archivo que se esté editando.
9. vim-ctrlspace: Administración de pestañas, búferes, archivos, entre otros.
10. ack.vim: Búsquedas
11. FixedTaskList.vim: Basado en la lista de tareas de Eclipse. Busca archivos que tengan tareas pendientes.
12. supertab: Ofrece un mejor soporte para el completado con la clave: ```<TAB>```.
13. vim-indentguides: Ofrece una representación visual de los espacios de indentación.
14. vim-commentary: Ofrece una mayor funcionalidad (que la que trae por defecto) al momento de realizar comentarios.
15. rust.vim: Soporte para el lenguaje de programación Rust
16. vim-startify: Su repositorio lo cataloga como: **The fancy start screen for vim.** (Nada que agregar ;-).
17. lightline.vim: Barra de estado de estado ligera y personalizable.

**Temas:**

1. Ayu: Para la sintaxis en general (Se puede cambiar)
2. vim-snazzy: Para la barra de estado (Se puede cambiar)

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
