$ftpRemote = "ftp://ftp.absorbtraining.com/absorb-prod.070714.bak"
$ftpLocal = "C:\ftp\absorb-prod.070714.bak"

$username = "ftp.lee"
$password = "LeeAbsorb70"
$client = New-Object System.Net.WebClient
$credentials = New-Object System.Net.NetworkCredential -arg $username, $password
$client.Credentials = $credentials

$ErrorActionPreference = "silentlyContinue"
#$client.DownloadFile($ftpRemote, $ftpLocal)
$client.UploadFile($ftpRemote, $ftpLocal)

if ($? -eq $false) {
  write-warning $error[0]
  # Retry logic, or send failure message
} else {
  "File xfer success"
}