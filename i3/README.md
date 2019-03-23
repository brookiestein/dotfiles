**_Software's necesarios:_**
```
i3-gaps
i3lock
rofi
feh
scrot
compton,
xfce4-power-manager
xfce4-clipman-plugin
lm_sensors
netifaces
psutil
setxkbmap
```

**Estos son los paquetes necesarios para esta configuración de i3.
El archivo "i3status.conf" no se utiliza, porque la barra que utilizo 
es bumblebee-status así que no es necesario, pero ahí está para quién no 
quiera bumblebee-status y utilice py3status porque la configuración que hay 
en este archivo funciona mejor con py3status.**

**Esta configuración está hecha tomando en cuenta que los archivos de i3 
están en ~/.config/i3, si no tienes tus archivos ahí, tendrás que modificar 
los archivos y establecer la ruta exacta de dónde están.**

**En el archivo config hay algunas líneas comentadas que seguro querrás 
descomentar, como por ejemplo el atajo de teclado para bloquear la pantalla.**

**Están comentadas porque tienen parámetros que exigen archivos, en este caso 
para el fondo. Hay otras líneas comentadas que son para ejecutar aplicaciones 
al inicio, en este caso es porque no todos tenemos los mismos programas y para 
que i3 no intente ejecutar un programa que, posiblemente no tengas instalado, 
están comentados.**

**Como última nota, te podrás dar cuenta que hay dos archivos de config: "config-generic" y "config-personal". Una es "genérica", es decir, con casi nula personalización, como atajos de teclado, aplicaciones que se ejecutan al iniciar el sistema, etc. Y la otra está más personalizada, con atajos de teclado que yo configuré para algunas aplicaciones que utilizo, con aplicaciones que quiero que se ejecuten cuándo inicio mi sistema, aplicaciones que se ejecutan en modo "ventana flotante", etc.
