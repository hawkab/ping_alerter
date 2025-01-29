param (
    [string]$IP_ADDRESS = "8.8.8.8"
)

$INTERVAL = 1  # Интервал проверки в секундах
$PINGED_ONCE = $false  # Флаг первого успешного пинга

Write-Host "📡 Мониторинг IP: $IP_ADDRESS"
Write-Host "Нажмите Ctrl+C для выхода.`n"

while ($true) {
    $pingResult = Test-Connection -ComputerName $IP_ADDRESS -Count 1 -Quiet

    if ($pingResult) {
        if (-not $PINGED_ONCE) {
            $FIRST_SUCCESS_TIME = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            Write-Host "`n🟢 $IP_ADDRESS стал доступен в $FIRST_SUCCESS_TIME"
            $PINGED_ONCE = $true
        }
        [console]::beep(1000, 500)  # Воспроизведение звукового сигнала (1 кГц, 500 мс)
        Start-Sleep -Milliseconds 500
    } else {
        Write-Host "`r$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | 🔴 $IP_ADDRESS пока не доступен... " -NoNewline
        $PINGED_ONCE = $false  # Если пинг пропал, сбрасываем флаг
        Start-Sleep -Seconds $INTERVAL
    }
}
