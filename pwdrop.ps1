#Set-myCredential.ps1
$File = "c:\script\powershell\pw.txt"
Param($File)
$Credential = Get-Credential
$credential.Password | ConvertFrom-SecureString | Set-Content $File