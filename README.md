# Menu-bandit-sv4-haciendo2
Para dar permisos chmod +x *.sh
./archivos-ficheros-comprimidos-inputs-nuevo.sh

Este es un script de shell que presenta un menú con varias opciones para mostrar el contenido de archivos y directorios,
buscar archivos, modificar flags especiales de archivos, y realizar otras operaciones. Cada opción tiene un nombre y un 
comando asociado separados por un carácter "|". El usuario ingresa el número de la opción deseada y se ejecuta el comando
correspondiente. El script incluye manejo de errores para opciones inválidas y pausa para continuar después de cada operación.
Las operaciones incluyen el uso de comandos como "cat", "find", "xargs", "sed", "awk", "grep", "sort", "uniq", "tail", "base64", 
"tr", entre otros. Algunos comandos también incluyen opciones y redirecciones como "> /dev/null" y "2>&1". El script es interactivo 
y se ejecuta indefinidamente hasta que el usuario decide salir.

Algunos ejemplos parcticando bash:

 flags especiales como root
# Para crear:
# chattr +l -V file.txt
# Para ver:
# lsattr
# Para eliminar:
# chattr -l -V file.txt

# En bandit 4:
# Encuentrameel nombre del archivo file(y algo)
# find . -name -file*

# which file
# Me dice que tipo de archivo es:
# file helado.jpg
# ┌──(nexxt㉿kali)-[~/Documentos/flag]
# └─$ file
# Usage: file [-bcCdEhikLlNnprsSvzZ0] [--apple] [--extension] [--mime-encoding]
#             [--mime-type] [-e <testname>] [-F <separator>]  [-f <namefile>]
#             [-m <magicfiles>] [-P <parameter=value>] [--exclude-quiet]
#             <file> ...
#        file -C [-m <magicfiles>]
#        file [--help]
                                                
# ┌──(nexxt㉿kali)-[~/Documentos/flag]
# └─$ echo $PATH
# /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games
                                                
# ┌──(nexxt㉿kali)-[~/Documentos/flag]
# └─$ 
# ===================
# Para ver en hexadecimal el archivo
# hexeditor file.txt
# ==================

# file inhear/*
# find . -name -file* | xargs file

# SOLUCION En bandit 4
# find . -name -file07 | xargs cat
# O:
# cat $(find . -name -file07)

# ============
# SOLUCION En bandit 5
# find .
# find -type f
# Con size le ponemos 1033c para buscar bytes
# Con la ! le decimos que no es ejecutable
# find -type f -readable ! -executable -size 1033c | xargs cat

# COMANDO sed
# cat /etc/passwd | head -1
# Solo cambia la 1º de la izquierda
# cat /etc/passwd | head -1 sed 's/root/norrot/'
# De forma global abajo /g
# cat /etc/passwd | head -1 sed 's/root/norrot/g'
# Para quitar la palabra root
# cat /etc/passwd | head -1 sed 's/root/norrot//g'

# Encontrar la palabra hola con sed en un archivo
# cat /usr/shared/wordlist/rockyou.txt | grep "ĥola$"

# Encontrar la linea de la palabra hola con sed en un archivo
# cat /usr/shared/wordlist/rockyou.txt | grep "ĥola$" -n

# Muestrame lo que hay en la linea x con awk
# cat /usr/shared/wordlist/rockyou.txt | awk 'NR==18876'

# SOLUCION bandit 5 a 6
# Para quitar espacios adicionales:
# find -type f -readable ! -executable -size 1033c | xargs cat | xargs

# Me da error:
# Con sed: para quitar los espacios:
# find -type f -readable ! -executable -size 1033c | xargs cat | sed 's^* //'


# ============
# SOLUCION bandit 6 a 7
# Asi me salen errores(abajo) permiso denegado
# find / -user bandit7 -group bandit6 -size 33c
# Quiero que los errores el stderr rediriga al dev null
# find / -user bandit7 -group bandit6 -size 33c 2>/dev/null
# ===============
# SOLUCION 6 a 7
# find / -user bandit7 -group bandit6 -size 33c 2>/dev/null | xargs cat
# =================
# Para ir a tomar por culo el equipo no hacer:
# mv /* /dev/null
# convertimos stder en stdin :
# cat /etc/passwd 2>&1
# Para abrir firefox por consola sin ver nada en consola y abrimos firefox en 2ºplano(si cerramos la consola se cierra)
# firefox > /dev/null 2>&1 &
# Para independizar un comando :
# disown -a 
# O:
# disown
# Podemos cerrar consola sin cerrar firefox
# ===============
# SOLUCION 6 a 7
# find / -user bandit7 -group bandit6 -size 33c 2>/dev/null | xargs cat
# =================
# ===============
# SOLUCION 7 a 8
# ENUNCIADO
# La contraseña esta en un archivo data.txt cerca de la palabra millio
# Para ver el nº de lineas
# cat data.txt | wc -C

# SOLUCION 7 a 8
# No tiene sentido dos comandos 
# cat data.txt | grep "millionth"
# Asi mejor que arriba tarda menos que awk
# time grep "millionth" data.txt
# SOLUCION 7 a 8
# No tiene sentido dos comandos
# Con awk
# cat data.txt | awk '/millionth/'
# Asi mejor que arriba
# time awk '/millionth/' data.txt
# Muestrame el argumento 2
# SOLUCION 7 a 8
# time awk '/millionth/' data.txt | awk '{print $2}'

# COMANDO CUT
# QUiero filtrar el primer campo a la izquierda
# echo "Hola    que tal" | cut -d '' -f 1
# QUiero filtrar el segundo campo empezando de izquierda(no vemos nada hay espacio)
# echo "Hola    que tal" | cut -d '' -f 2
# QUiero filtrar el segundo campo empezando de izquierda(no vemos nada hay espacio) con awk me da resultado que
# echo "Hola    que tal" | awk '{print $2}'

# QUiero filtrar el sexto campo empezando de izquierda( vemos que)
# echo "Hola    que tal" | cut -d '' -f 6

# COMANDO ESPECIAL AWK SOLUCION 7 a 8
# awk '/millionth/' data.txt | awk 'NF{print $NF}'
# COMANDO ESPECIAL AWK SOLUCION 7 a 8

# Revertimos cadena con awk:
# awk '/millionth/' data.txt | rev
# Mostramos el primer argumento:
# awk '/millionth/' data.txt | rev | awk '{print $1}'
# Volvemos a revertir para ver normal
# awk '/millionth/' data.txt | rev | awk '{print $1}'| rev
# Ver lo que hay en la linea 37267 (solucion 7 a 8)
# awk 'NR==37262' data.txt

# =================
# ============

# ============
# SOLUCION 8 a 9
# El pasword se encuentra en el archivo data.txt y es la unica linea de texto que ocurre una unica vez
# Ver el texto del fichero
# cat data.txt
# COntamos las lineas 
# cat data.txt | wc -l
# Ordenamos y mostramos la linea unica SOLUCION 8 a 9
# cat data.txt | wc -l | sort
# cat data.txt | wc -l | sort | uniq -u
# SOLUCION BUENA
bandit8@bandit:~$ cat data.txt |  sort | uniq -u
EN632PlfYiZbn3PhVK3XOGSlNInNE00t
bandit8@bandit:~$ 
# La unica linea que no se repite es como un uniq -u:
# whith unique

# ============
# ============
# SOLUCION 9 a 10
# Esta el passwor en data.txt y esta precedida de varios ===
# Hacemos cat a data.txt no es legible
# strings data.txt | grep "==="
# Muestrame la ultima linea tiene 4:
# strings data.txt | grep "===" | tail -n 1

# ============

# SOLUCION bandit 9  a 10
# Escrimos lo mismo que arriba pero en la consola sin contador
# strings data.txt | grep "===" | while read line; do echo "Hola: $line"; done 
# Escrimos lo mismo que arriba pero en la consola con contador
contador=1; strings data.txt | grep "===" | while read line; do echo "Linea $contador: $line"; let contador+=1; done | awk 'NR==4{print $NF}'

# ///////////////////////////////////
# ///////////////////////////////////
