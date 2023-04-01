#!/bin/bash

# Definimos un array con las opciones del menú. Cada opción es una cadena con dos partes separadas por el carácter '|': el nombre de la opción y el comando correspondiente.
opciones=(
    "Salir:|exit 0"
    "Mostrar contenido de archivo:|./leer-archivo-input.sh"
    "Mostrar contenido del directorio actual (./-):|cat ./-"
    "Mostrar contenido del directorio actual ($(pwd)/-):|cat $(pwd)/-"
    "Mostrar contenido del directorio /home/bandit1/ usando -:|cat /home/bandit1/-"
    "Mostrar contenido del directorio /home/bandit1/ usando *:|cat /home/bandit1/*"
    "Mostrar contenido del directorio actual ($(pwd)/*):|cat $(pwd)/*"
    "Mostrar contenido de archivo con espacios en el nombre:|echo \"cat spaces\\ in\\ this\\ filename\""
    "Mostrar archivos que comienzan con \"cp\":|echo \"cat cp*\""
    "Mostrar archivos que contienen \"ame\":|echo \"cat *ame\""
    "Mostrar contenido del directorio /home/bandit2/ usando *:|cat /home/bandit2/*"
    "Mostrar contenido del directorio actual usando *:|cat $(pwd)/*"
    "Encontrar ficheros en el directorio actual:|find . -type f"
    "Encontrar ficheros en el directorio actual con información detallada:|find . -type f -printf '%f\t%p\t%u\t%g\t%m\n'| column -t"
    "Encontrar archivos que contienen la palabra \"leaving\" con find y xargs:|find -type f | xargs grep 'leaving'"
    "Agregar flags especiales a un archivo:|sudo chattr +l -V file.txt"
    "Ver los flags especiales de un archivo:|lsattr"
    "Eliminar flags especiales de un archivo:|sudo chattr -l -V file.txt"
    "Mostrar contenido de archivos de tamaño 1033 bytes no ejecutables y legibles en el nivel 5:|find -type f -readable ! -executable -size 1033c | xargs cat"
    "Mostrar contenido de archivos de tamaño 1033 bytes no ejecutables y legibles en el nivel 5 sin espacios adicionales:|find -type f -readable ! -executable -size 1033c | xargs cat | xargs"
    "Mostrar contenido de archivos de tamaño 1033 bytes no ejecutables y legibles en el nivel 5 sin espacios adicionales:|find -type f -readable ! -executable -size 1033c | xargs cat | sed 's/^ *//'"
    "Mostrar contenido de archivo de tamaño 33 bytes propiedad de bandit7 y grupo de bandit6 en el nivel 6:|find / -user bandit7 -group bandit6 -size 33c 2>/dev/null | xargs cat"
    "Redirigir stderr a /dev/null en el nivel 6:|find / -user bandit7 -group bandit6 -size 33c 2>/dev/null"
    "Convertir stderr en stdin en el nivel 6:|cat /etc/passwd 2>&1"
    "Abrir Firefox en segundo plano en el nivel 6:|firefox > /dev/null 2>&1 &"
    "Independizar un proceso del terminal en el nivel 6:|disown -a"
    "Mostrar contenido de archivo data.txt filtrando por la palabra "millionth" y mostrando la segunda columna:|awk '/millionth/' data.txt | awk '{print $2}'"
    "Revertir la cadena del contenido de archivo data.txt filtrando por la palabra "millionth":|awk '/millionth/' data.txt | rev"
    "Mostrar la primera palabra de la cadena revertida del contenido de archivo data.txt filtrando por la palabra "millionth":|awk '/millionth/' data.txt | rev | awk '{print $1}'"
    "Mostrar la línea 37262 del archivo data.txt:|awk 'NR==37262' data.txt"
        "Mostrar contenido de archivo y contar líneas:|cat data.txt && wc -l data.txt"
    "Buscar todas las líneas que contengan la palabra 'millionth' y eliminar duplicados:|grep 'millionth' data.txt | sort | uniq"
    "Buscar todas las líneas que contengan la palabra 'millionth' y contar cuántas veces aparece cada una:|grep 'millionth' data.txt | sort | uniq -c"
    "Mostrar las líneas que contienen la palabra 'millionth' y ordenarlas alfabéticamente:|grep 'millionth' data.txt | sort"
    "Mostrar las líneas que contienen la palabra 'millionth' y ordenarlas alfabéticamente (en orden inverso):|grep 'millionth' data.txt | sort -r"
    "Mostrar las líneas que contienen la palabra 'millionth' y eliminar duplicados, contando cuántas veces aparece cada una:|grep 'millionth' data.txt | sort | uniq -c"
    "Mostrar las líneas que contienen la palabra 'millionth' y contar cuántas veces aparece cada una, ordenando por número de ocurrencias (mayor a menor):|grep 'millionth' data.txt | sort | uniq -c | sort -nr"
    "Encontrar la última línea que contiene '===' en el archivo data.txt sin contador:|strings data.txt | grep '===' | tail -n 1"
    "Encontrar todas las líneas que contienen '===' en el archivo data.txt sin contador:|strings data.txt | grep '==='"
    "Encontrar la contraseña en el archivo data.txt con contador:|contador=1; strings data.txt | grep '===' | while read line; do echo \"Linea \$contador: \$line\"; let contador+=1; done | awk 'NR==4{print \$NF}'"
    "Encontrar la contraseña en el archivo data.txt sin contador:|strings data.txt | grep '===' | tail -n 1 | awk '{print \$NF}'"
    "Decodificar cadena en base64 y convertir espacios en saltos de línea con tr:|cat data.txt | base64 -d | tr ' ' '\n'"
    "Decodificar cadena en base64 y convertir espacios en saltos de línea con sed:|cat data.txt | base64 -d | sed 's/ /\n/g'"
    "Decodificar cadena rotada en archivo data.txt:|cat data.txt | tr '[A-Za-z]' '[N-ZA-Mn-za-m]' | awk 'NF{print $NF}'"

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
