Software's necesarios:

i3-gaps
i3lock
rofi
feh
scrot
compton,
xfce4-power-manager
lm_sensors
netifaces
psutil

Estos son los paquetes necesarios para esta configuración de i3.
El archivo "i3status.conf" no se utiliza, porque la barra que utilizo 
es bumblebee-status así que no es necesario, pero ahí está para quién no 
quiera bumblebee-status y utilice py3status porque la configuración que hay 
en este archivo funciona mejor con py3status.

Esta configuración está hecha tomando en cuenta que los archivos de i3 
están en ~/.config/i3, si no tienes tus archivos ahí, tendrás que modificar 
los archivos y establecer la ruta exacta de dónde están. 

En el archivo config hay algunas líneas comentadas que seguro querrás 
descomentar, como por ejemplo el atajo de teclado para bloquear la pantalla. 

Están comentadas porque tienen parámetros que exigen archivos, en este caso 
para el fondo. Hay otras líneas comentadas que son para ejecutar aplicaciones 
al inicio, en este caso es porque no todos tenemos los mismos programas y para 
que i3 no intente ejecutar un programa que, posiblemente no tengas instalado, 
están comentados.
