#!/bin/bash

# Definimos un array con las opciones del menú. Cada opción es una cadena con dos partes separadas por el carácter '|': el nombre de la opción y el comando correspondiente.
opciones=(
      "Salir:|exit 0"
    "Ejer1 bandit0:|echo \"Para conectarme al nivel 0 : 3\nMe pide contraseña: bandit0\n\nBandido Nivel 0 → Nivel 1\nObjetivo de nivel\nLa contraseña para el siguiente nivel se almacena en un archivo llamado Léame ubicado en el directorio de inicio. Use esta contraseña para iniciar sesión en bandit1 usando SSH. Siempre que encuentre una contraseña para un nivel, use SSH (en el puerto 2220) para iniciar sesión en ese nivel y continuar el juego.\n\nComandos que puedes necesitar para resolver este nivel\nls , cd , gato , archivo , du , encontrar\n\ncat readme y la contraseña:boJ9jbbUNNfktd78OOpsqOltutMc3MY1\ncat /home/bandit1/- otr forma cat /home/bandit1/*\n\"; read foo"
    "Ejer2 bandit1:|echo \"Bandido Nivel 1 → Nivel 2\nObjetivo de nivel\nLa contraseña para el siguiente nivel se almacena en un archivo llamado - ubicado en el directorio de inicio\n\nComandos que puedes necesitar para resolver este nivel\nls , cd , gato , archivo , du , encontrar\n\ncat ./-\nCV1DtqXWVFXTvM2F0k09SHz0YwRINYA9 \n\n============\nOtra forma por ruta absoluta cat /home/bandit1/-\n\n============\nOtra forma por ruta absoluta cat /home/bandit1/*\n\n============\nOtra forma por output aplicado a nivel de sistema  cat $(pwd)/-\n\n============\nOtra forma por output aplicado a nivel de sistema  cat $(pwd)/*\n\"; read foo"
    "Ejer3 bandit2:|echo \"Bandido Nivel 2 → Nivel 3\nObjetivo de nivel\nLa contraseña para el siguiente nivel se almacena en un archivo llamado espacios en este nombre de archivo ubicado en el directorio de inicio\n\nComandos que puedes necesitar para resolver este nivel\nls , cd , gato , archivo , du , encontrar\n\ncat spaces\\ in\\ this\\ filename \ncat cp* o con cat *ame o con cat *this\ncat /home/bandit2/*\ncat $(pwd)/* o con cat *\naBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG\n\"; read foo"
    "Ejer5 bandit3:|echo \"Bandido Nivel 3 → Nivel 4\nObjetivo de nivel\nLa contraseña para el siguiente nivel está almacenada en un archivo oculto en el directorio inhere.\n\nComandos que puedes necesitar para resolver este nivel\nls , cd , gato , archivo , du , encontrar\n\nbandit3@bandit:~$ ls\ninhere\nbandit3@bandit:~$ find .\n.\n./.

)

while true; do
    clear
    echo "Ingrese el número de la opción deseada:"
    for i in "${!opciones[@]}"; do
        echo "$i. ${opciones[$i]%%|*}" # Imprimimos el índice de la opción y su nombre (sin el comando correspondiente).
    done
    read opcion

    case $opcion in
        ''|*[!0-9]*)  # Si la opción no es un número válido
            echo "Opción inválida. Presione Enter para continuar..."
            read
            ;;
        *)  # Si la opción es un número válido
            if [ $opcion -lt 0 ] || [ $opcion -ge ${#opciones[@]} ]; then
                # Si la opción está fuera del rango de opciones
                echo "Opción inválida. Presione Enter para continuar..."
                read
            else
                clear
                comando="${opciones[$opcion]#*|}" # Obtenemos el comando correspondiente a la opción seleccionada.
                eval "$comando"                   # Ejecutamos el comando.
                echo ""
                echo "Presione Enter para continuar..."
                read
            fi
            ;;
    esac

done
