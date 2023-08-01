#!/bin/bash 
#
# Script para configurar o servidor DNS no arquivo /etc/resolv.conf.
#
# Vitor de Jesus
# CVS $Header$


# Função para configurar o DNS
configure_dns() {
    local dns_server="$1"

    # Verifica se o DNS foi fornecido como argumento
    if [ -z "$dns_server" ]; then
        echo "Por favor, informe o endereço do servidor DNS como argumento."
        echo "Exemplo: $0 8.8.8.8"
        exit 1
    fi

    # Verifica se o usuário é root (ou tem privilégios de sudo)
    if [ "$(id -u)" -ne 0 ]; then
        echo "Este script precisa ser executado com privilégios de superusuário (root)."
        exit 1
    fi

    # Backup do arquivo resolv.conf
    cp /etc/resolv.conf /etc/resolv.conf.bkp

    # Configura o novo servidor DNS no arquivo resolv.conf
    echo "nameserver $dns_server" > /etc/resolv.conf

    echo "Configuração de DNS concluída. O novo servidor DNS é $dns_server."
}

# Uso do script
if [ "$#" -eq 0 ]; then
    echo "Este script configura o servidor DNS no arquivo /etc/resolv.conf."
    echo "Uso: $0 <endereço_do_servidor_dns>"
    echo "Exemplo: $0 8.8.8.8"
else
    configure_dns "$1"
fi
