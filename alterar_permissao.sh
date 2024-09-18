#!/bin/bash

Lista de diretórios a serem monitorados
MONITORAR_LISTA=(
    "/diretorio/que/quiser/"
)

Função para ajustar permissões de arquivos recém-criados
ajustar_permissoes() {
    local arquivo="$1"
    chown docker:docker "$arquivo"
    echo "Permissões ajustadas para $arquivo"
}

Ajustar permissões para arquivos existentes
ajustar_permissoes_existentes() {
    local diretorio="$1"
    chown -R docker:docker "$diretorio"
    echo "Permissões ajustadas recursivamente para todos os arquivos em $diretorio"
}

Monitorar diretórios
for MONITORAR in "${MONITORAR_LISTA[@]}"; do
    # Ajustar permissões para arquivos já existentes
    ajustar_permissoes_existentes "$MONITORAR"

    (
        echo "Iniciando monitoramento para: $MONITORAR"
        inotifywait -m -r -e create --format '%w%f' "$MONITORAR" | while read -r arquivo; do
            ajustar_permissoes "$arquivo"
        done
    ) &
done

Esperar todos os processos em background terminarem
wait
