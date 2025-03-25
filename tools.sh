#!/usr/bin/env bash
set -e

ROOT_DIR="${LLM_ROOT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"

# Función para listar los ficheros y contar las extensiones en un directorio dado
# @option --path! La ruta donde se van a listar los ficheros
fs_ls() {
    if [ -d "$argc_path" ]; then
        find "$argc_path" -type f | \
        sed -E 's/.*\.(.*)/\1/' | \
        sort | \
        uniq -c | \
        awk '{print "{\"extension\": \""$2"\", \"count\": "$1"}"}' | \
        paste -sd, - | \
        sed 's/^/[ /; s/$/ ]/'
    else
        echo "Error: La ruta '$argc_path' no es válida o no existe."
    fi
}

# Evaluamos los comandos proporcionados para su ejecución
eval "$(argc --argc-eval "$0" "$@")"
