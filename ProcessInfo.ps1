$services = Get-WMIObject win32_service | ? {$_.startmode -eq "Auto"}; 

foreach($service in $services)
{
Write-host "Name: "$service.name
write-host "Display Name: "$service.DisplayName
write-host "Service Status: "$service.Status
write-host "Error Control: "$service.ErrorControl
write-host "Start Mode: "$Service.StartMode
write-host "Started: "$Service.Started
write-host "Process ID: "$Service.ProcessId
write-host "`r"
}

