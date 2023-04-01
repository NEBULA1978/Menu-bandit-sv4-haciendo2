#!/bin/bash

echo "Mostrando archivos en la ruta actual:"
ls
while true; do
  read -p "Introduzca el nombre del archivo: " archivo
  if [ -f "$archivo" ]; then
    echo "Mostrando contenido de $archivo:"
    cat "$archivo"
    break
  else
    echo "Archivo no encontrado. Intente de nuevo."
  fi
done
