Get-Content /home/kali/Desktop/ms1/sensitive.ps1 | ForEach-Object {$ExecutionContext.InvokeCommand.ExpandString($_)}
$message="Тестовое сообщение в Telegram из PowerShell"
$Response = Invoke-RestMethod -Uri "https://api.telegram.org/bot$($Telegramtoken)/sendMessage?chat_id=$($Telegramchatid)&text=$($Message)"
