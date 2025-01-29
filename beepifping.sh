#!/bin/bash

# Используем переданный IP или значение по умолчанию
IP_ADDRESS="${1:-8.8.8.8}"
INTERVAL=1  # Интервал проверки в секундах
PINGED_ONCE=false  # Флаг первого успешного пинга

echo "📡 Мониторинг IP: $IP_ADDRESS"
echo "Нажмите Ctrl+C для выхода."

while true; do
    if ping -c 1 -W 1 "$IP_ADDRESS" &> /dev/null; then
        if [ "$PINGED_ONCE" = false ]; then
            FIRST_SUCCESS_TIME=$(date '+%Y-%m-%d %H:%M:%S')
            echo -e "\n🟢 $IP_ADDRESS стал доступен в $FIRST_SUCCESS_TIME"
            PINGED_ONCE=true
        fi
        echo -ne "\a"  # Воспроизведение звукового сигнала
        sleep 0.5
    else
        echo -ne "$(date '+%Y-%m-%d %H:%M:%S') | 🔴 $IP_ADDRESS пока не доступен...   \r"
        PINGED_ONCE=false  # Если пинг пропал, флаг сбрасывается
        sleep "$INTERVAL"
    fi
done
