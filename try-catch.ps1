<# Script para enviar mensagens ao telegram via powershell.
    Autor: Vinicius dos Santos Fernandes
    Link do repositório: https://github.com/Vinaum8/pwsh-notify-telegram
# Contatos:
        # Email: vinaumpt@gmail.com
        # Linkedin: https://www.linkedin.com/in/vinisf/
# Version: 1.0
#
# -------------------------------------------------------------------------- #
#
# Este script basicamente coleta as variáveis de ambiente do telegram setadas no seu servidor ou container e envia a mensagem de retorno do try-catch para o chat ID.
#
# Exemplos de Execução:
#       $ ./try-catch.ps1
        Você também pode executar este script via docker com a imagem https://hub.docker.com/_/microsoft-powershell

#>

$global:servername = $(Get-CimInstance -ClassName Win32_ComputerSystem).Name

try {
    # command   
} catch {
    $deuruim = ($_.Exception.Message)
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;

    $MyToken = $([System.Environment]::GetEnvironmentVariables().telegram_token)
    $chatID = $([System.Environment]::GetEnvironmentVariables().telegram_chat_id)

    $Message = "Erro! => `n`n Servidor: $servername`n`n" + "Erro: $deuruim"
    Invoke-RestMethod -Uri "https://api.telegram.org/bot$($MyToken)/sendMessage?chat_id=$($chatID)&text=$($Message)"
}