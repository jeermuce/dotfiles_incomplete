#!/bin/bash

# Ruta del archivo a verificar
FILE="next.config.js"

# Buscar la cadena 'unoptimized: false'
if grep -q 'unoptimized: false' "$FILE"; then
  echo "Found 'unoptimized: false' in $FILE"

  # Cambiar la cadena a 'unoptimized: true'
  sed -i 's/unoptimized: false/unoptimized: true/g' "$FILE"

  # Unstage el archivo
  git reset "$FILE"

  # Añadir el archivo de nuevo al staging area
  git add "$FILE"

  echo "The file $FILE was modified and staged again. Please commit again."
  
  # Salir con un error para detener el commit original
  exit 1
fi

# Si no se encontró la cadena, continuar con el commit normal
exit 0
