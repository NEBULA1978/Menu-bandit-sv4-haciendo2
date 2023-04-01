#!/bin/bash

# Definimos un array con las opciones del menú. Cada opción es una cadena con dos partes separadas por el carácter '|': el nombre de la opción y el comando correspondiente.
opciones=(
    "Salir:|exit 0"
    "Mostrar contenido de archivo:|./leer-archivo-input.sh"
    "Mostrar contenido del directorio actual:|cat $(pwd)/-"
    "Mostrar contenido de archivos con simbolo:|while true; do read -p 'Introduzca el símbolo que desea buscar: ' simbolo && [ -n \"$simbolo\" ] && break; echo 'Símbolo inválido. Intente de nuevo.'; done; grep -r \"$simbolo\" ."
    "Mostrar contenido de archivos con asterisco:|while true; do read -p 'Introduzca el patrón de archivo que desea buscar: ' patron && [ -n \"$patron\" ] && break; echo 'Patrón inválido. Intente de nuevo.'; done; cat $patron*"
)

while true; do
    echo "Ingrese el número de la opción deseada:"
    for i in "${!opciones[@]}"; do
        echo "$i. ${opciones[$i]%%|*}"
    done
    read opcion

    case $opcion in
        ''|*[!0-9]*)
            echo "Opción inválida. Presione Enter para continuar..."
            read
            ;;
        *)
            if [ $opcion -lt 0 ] || [ $opcion -ge ${#opciones[@]} ]; then
                echo "Opción inválida. Presione Enter para continuar..."
                read
            else
                comando="${opciones[$opcion]#*|}"
                echo "${opciones[$opcion]%%|*}"
                eval "$comando"
                echo ""
                echo "Presione Enter para continuar..."
                read
            fi
            ;;
    esac
done
