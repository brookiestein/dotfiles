#!/bin/bash
message="¿Desea tener soporte para"
answer="La respuesta introducida no es válida."
welcome() {
        echo "##############################################################################################"
        echo "##### Bienvenido al script de automatización del proceso de compilación del núcleo linux #####"
        echo "##############################################################################################"
}

verify() {
        cd /usr/src/linux/
        echo
        if [ ! -f ".config" ]; then
                echo "Archivo de configuración no encontrado." && echo
                sleep 2
                if [ -f "/usr/src/linux-$(uname -r)/.config" ]; then
                        echo "Archivo de configuración anterior encontrado. Copiando a las nuevas fuentes..."
                        sleep 2
                        cp /usr/src/linux-$(uname -r)/.config /usr/src/linux/
                        if [ $? != '0' ]; then
                                echo && echo "No se ha encontrado el archivo de configuración para compilar las fuentes y no se ha podido"
                                echo "copiar desde las fuentes anteriores. Por favor, verifique la existencia de este archivo o"
                                echo "procesa a realizar la configuración correspondiente, e.g (make menuconfig/gconfig, etc.)"
                                status=1
                        else
                                echo && echo "Sincronizando configuración anterior..." && echo
                                sleep 2
                                make olddefconfig
                                if [ $? != '0' ]; then
                                        echo && echo "Ha ocurrido un error al sincronizar las configuraciones anteriores con las nuevas." && echo
                                else
                                        echo && echo "Sincronización realizada exitosamente." && echo
                                        status=0
                                fi
                        fi
                else
                        echo && echo "No se ha encontrado el archivo de configuración para compilar las fuentes en: /usr/src/linux/ o"
                        echo "/usr/src/linux-$(uname -r). Por favor, verifique la existencia de este archivo o procesa a realizar"
                        echo "la configuración correspondiente, e.g (make menuconfig/gconfig, etc.)"
                        status=1
                fi
        else
                echo && echo "Archivo de configuración encontrado."
                sleep 2
                status=0
        fi
}

get_threads() {
        echo && echo -n "¿Cuántos hilos de su procesador desea utilizar para esta compilación? (1 por defecto): "
        read threads
        echo -en $threads | grep '[[:digit:]]' > /dev/null 2> /dev/null

        while [[ $? -ne 0 || $threads -le 0 ]]; do
                if [[ -z $threads ]]; then
                        threads=1
                        break
                else
                        echo && echo "La cantidad de hilos introducida no es válida."
                        echo -n "¿Cuántos hilos de su procesador desea utilizar para esta compilación? (1 por defecto): "
                        read threads
                        echo -en $threads | grep '[[:digit:]]' > /dev/null 2> /dev/null
                fi
        done
}

get_info() {
        echo "A continuación dígame si desea que su initramfs tenga soporte para LVM y/o LUKS."
        # Ask by support for LUKS
        echo && echo -n "$message LUKS? [S/n]: "
        read luks
        while [[ $luks != 's' && $luks != 'si' && $luks != 'n' && $luks != 'no' ]]; do
                echo && echo "$answer" && echo -n "$message LUKS? [S/n]: "
                read luks
        done

        # Ask by support for LVM
        echo && echo -n "$message LVM? [S/n]: "
        read lvm
        while [[ $lvm != 's' && $lvm != 'si' && $lvm != 'n' && $lvm != 'no' ]]; do
                echo && echo "$answer" && echo -n "$message LVM? [S/n]: "
                read lvm
        done

        # Get the number of threads for the compilation
        cores=$(cat /proc/cpuinfo | grep "cpu cores")
        cores=${cores:${#cores}-2}
        get_threads

        while [ $threads -gt $((cores*2+1)) ]; do
                echo && echo "La cantidad de hilos que ha decidido utilizar es: $threads y su procesador"
                echo -n "cuenta con sólo $((cores*2)). Esto no es recomendable. ¿Desea continuar con esta configuración? [S/n]: "
                read confirm
                while [[ $confirm != 's' && $confirm != 'si' && $confirm != 'n' && $confirm != 'no' ]]; do
                        echo && echo "La respuesta introducida no es válida."
                        echo -n "¿Desea continuar con esta configuración? [S/n]: "
                        read confirm
                done

                if [[ $confirm = 's' || $confirm = 'si' ]]; then
                        echo && echo "Continuando con una configuración no recomendada."
                        sleep 2
                        break
                else
                        get_threads
                fi
        done

        if [[ $threads -eq 1 ]]; then
                echo "Seleccionado $threads hilo para compilar."
        else
                echo "Seleccionados $threads hilos para compilar."
        fi
}

user=$(echo $USER)
if [ $user = 'root' ]; then
        clear
        # Get information to work
        welcome
        verify
        if [ $status -eq 0 ]; then
                get_info
                # Start to work
                echo && echo "Bien. Ya tengo los datos necesarios para trabajar."
                echo -n "Trabajando con las opciones: "

                if [[ $luks = 's' || $luks = 'si' ]]; then
                        echo -n "LUKS = Sí, "
                else
                        echo -n "LUKS = No, "
                fi

                if [[ $lvm = 's' || $lvm = 'si' ]]; then
                        echo -n "LVM = Sí, "
                else
                        echo -n "LVM = No, "
                fi

                echo "Hilos = $threads"
                echo "Entrando en el directorio..." && echo
                sleep 2

                cd /usr/src/linux/
                if [ $? = '0' ]; then
                        echo "La compilación del núcleo iniciará en 5 segundos. Puede presionar (CTRL + C) para cancelar esto."
                        echo -n "("
                        for ((i=5; i>=1; i--)); do
                                if [ $i -gt 1 ]; then
                                        echo -n "$i, "
                                else
                                        echo "$i)" && echo
                                fi
                                sleep 1
                        done

                        make -j$threads
                        if [ $? = '0' ]; then
                                echo && echo "Compilación finalizada. Instalando módulos..." && echo
                                sleep 2
                                make modules_install
                                if [ $? = '0' ]; then
                                        echo && echo "Instalación de módulos finalizada. Instalando núcleo..." && echo && sleep 2
                                        make install
                                        if [ $? = '0' ]; then
                                                echo && echo "Instalación del núcleo finalizada. Generando initramfs..." && echo && sleep 2
                                                if [[ $lvm = 's' || $lvm = 'si' && $luks = 's' || $luks = 'si' ]]; then
                                                        genkernel --lvm --luks --install initramfs
                                                        if [ $? = '0' ]; then
                                                                echo && echo -n "Generación de initramfs finalizada. Re(generando) archivo de "
                                                                echo "configuración de GRUB..." && echo && sleep 2
                                                                grub-mkconfig -o /boot/grub/grub.cfg
                                                                if [ $? = '0' ]; then
                                                                        echo && echo -n "Generación de archivo de configuración de "
                                                                        echo "GRUB finalizada con éxito."
                                                                        echo "¡Trabajo finalizado!" && echo && sleep 2

                                                                else
                                                                        echo && echo -n "Ha ocurrido un error en la (re)generación del archivo "
                                                                        echo "de configuración de GRUB. Saliendo..." && sleep 2
                                                                fi
                                                        else
                                                                echo && echo "Ha ocurrido un error en la generación del initramfs. Saliendo..."
                                                                sleep 2
                                                        fi
                                                elif [[ $lvm = 's' || $lvm = 'si' && $luks = 'n' || $luks = 'no' ]]; then
                                                        genkernel --lvm --install initramfs
                                                        if [ $? = '0' ]; then
                                                                echo && echo -n "Generación de initramfs finalizada. Re(generando) archivo de "
                                                                echo "configuración de GRUB..." && sleep 2
                                                                grub-mkconfig -o /boot/grub/grub.cfg
                                                                if [ $? = '0' ]; then
                                                                        echo
                                                                        echo -n "Generación de archivo de configuración de GRUB "
                                                                        echo "finalizada con éxito. "
                                                                        echo "¡Trabajo finalizado!" && echo && sleep 2

                                                                else
                                                                        echo && echo -n "Ha ocurrido un error en la (re)generación del archivo de "
                                                                        echo "configuración de GRUB. Saliendo..." && sleep 2
                                                                fi
                                                        else
                                                                echo && echo "Ha ocurrido un error en la generación del initramfs. Saliendo..."
                                                                sleep 2
                                                        fi
                                                elif [[ $lvm = 'n' || $lvm = 'no' && $luks = 's' || $luks = 'si' ]]; then
                                                        genkernel --luks --install initramfs
                                                        if [ $? = '0' ]; then
                                                                echo && echo -n "Generación de initramfs finalizada. (Re)generando archivo de "
                                                                echo "configuración de GRUB..." && sleep 2
                                                                grub-mkconfig -o /boot/grub/grub.cfg
                                                                if [ $? = '0' ]; then
                                                                        echo && echo -n "Generación de archivo de configuración de GRUB "
                                                                        echo "finalizada con éxito."
                                                                        echo "¡Trabajo finalizado!" && echo && sleep 2

                                                                else
                                                                        echo && echo -n "Ha ocurrido un error en la (re)generación del archivo de "
                                                                        echo "configuración de GRUB. Saliendo..." && sleep 2
                                                                fi
                                                        else
                                                                echo && echo "Ha ocurrido un error en la generación del initramfs. Saliendo..."
                                                                sleep 2
                                                        fi
                                                else
                                                        genkernel --install initramfs
                                                        if [ $? = '0' ]; then
                                                                echo && echo -n "Generación de initramfs finalizada. Re(generando) archivo de "
                                                                echo "configuración de GRUB..." && sleep 2
                                                                grub-mkconfig -o /boot/grub/grub.cfg
                                                                if [ $? = '0' ]; then
                                                                        echo && echo -n "Generación de archivo de configuración de GRUB "
                                                                        echo "finalizada con éxito."
                                                                        echo "¡Trabajo finalizado!" && echo && sleep 2

                                                                else
                                                                        echo && echo -n "Ha ocurrido un error en la (re)generación del archivo de "
                                                                        echo "configuración de GRUB. Saliendo..." && sleep 2
                                                                fi
                                                        else
                                                                echo && echo "Ha ocurrido un error en la generación del initramfs. Saliendo..."
                                                                sleep 2
                                                        fi
                                                fi
                                        else
                                                echo && echo "Ha ocurrido un error en la instalación del núcleo." && echo "Saliendo..." && sleep 2
                                        fi
                                else
                                        echo && echo "Ha ocurrido un error en la instalación de los módulos. Saliendo..." && sleep 2
                                fi
                        else
                                echo && echo "Ha ocurrido un error en la compilación del kernel. Saliendo..." && echo && sleep 2
                        fi
                else
                        echo && echo "No se ha podido acceder al directorio. Saliendo..." && echo && sleep 2
                fi
        fi
else
        echo && echo "Se necesitan permisos de administrador para realizar las tareas." && echo
fi

