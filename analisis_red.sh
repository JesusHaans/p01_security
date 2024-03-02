#!/bin/bash

# Función para realizar análisis de dominio
domain_analysis() {
    domain="$1"
    echo "Realizando análisis para el dominio: $domain"
    # Obtener información WHOIS del dominio
    echo "Información WHOIS del dominio:"
    echo ======================= INICIANDO WHOIS ======================= > $domain\_analysis.txt
    whois $domain >> $domain\_analysis.txt
    # Realizar ping al dominio
    echo "Ping al dominio:"
    echo ======================= INICIANDO PING ======================= >> $domain\_analysis.txt
    ping -c 4 $domain >> $domain\_analysis.txt
    # Realizar traceroute al dominio
    echo "Traceroute al dominio:"
    echo ======================= INICIANDO TRACEROUTE ======================= >> $domain\_analysis.txt
    traceroute $domain >> $domain\_analysis.txt
    # Enumerar DNS
    echo "Enumerando DNS del dominio:"
    echo ======================= INICIANDO NSLOOKUP ======================= >> $domain\_analysis.txt
    nslookup -type=any $domain >> $domain\_analysis.txt
    # Escanear puertos con Nmap
    echo "Escaneando puertos del dominio:"
    echo ======================= INICIANDO NMAP ======================= >> $domain\_analysis.txt
    nmap -sV $domain >> $domain\_analysis.txt
}


# Función para realizar análisis de IP
ip_analysis() {
    ip="$1"
    echo "Realizando análisis para la IP: $ip"
    echo ======================= INICIANDO PING ======================= >> $ip\_analysis.txt
    # Realizar ping a la IP
    echo "Ping a la IP:"
    ping -c 4 $ip >> $ip\_analysis.txt
    # Realizar traceroute a la IP
    echo "Traceroute a la IP:"
    echo ======================= INICIANDO TRACEROUTE ======================= >> $ip\_analysis.txt
    traceroute $ip >> $ip\_analysis.txt
    # Escanear puertos con Nmap
    echo "Escaneando puertos de la IP:"
    echo ======================= INICIANDO NMAP ======================= >> $ip\_analysis.txt
    nmap -p- $ip >> $ip\_analysis.txt
}


# Función principal
main() {
# Verificar si se proporcionó un dominio o una IP como argumento
    if [[ -n "$1" ]]; then
        if [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            ip_analysis $1
        else
            domain_analysis $1
        fi
    else
        echo "Debe proporcionar un dominio o una IP como argumento."
        exit 1
    fi
}


# Llamada a la función principal con el argumento proporcionado
main "$1"
