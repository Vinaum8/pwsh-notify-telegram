$global:servername = $(Get-CimInstance -ClassName Win32_ComputerSystem).Name

try {
    # command   
} catch {
    $deuruim = ($_.Exception.Message)
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

    $MyToken = $([System.Environment]::GetEnvironmentVariables().telegram_token)
    $chatID = $([System.Environment]::GetEnvironmentVariables().telegram_chat_id)

    $Message = "Ocorreu erro realizando um backup!`n`nServidor: $servername`n`n" + "Erro: $deuruim"
    Write-Host [$message]
    Invoke-RestMethod -Uri "https://api.telegram.org/bot$($MyToken)/sendMessage?chat_id=$($chatID)&text=$($Message)"
}