function Set-ServiceStatus{
<#
.Synopisis
Start or stop a service on a remote computer and verify that has changed state.

.Description
This script will start or stop a service.  After the status change it will verify that it has changed.  It will also provide verbose logging
for future debugging if the scirpt fails later

.Author
Lee Carlson

.Version 1.0

.DateofLastUpdate
5.28.14

.PSVersion 4.0

.Parameter
-Start = Sets the service to start
-Stop = Sets the service to stop
-ComputerName = Name of machine where service runs
-ServiceName = Name of service running on that machine (NOT DISPLAY NAME)
#>
[CmdletBinding()]
param 
(
[switch]$Start,
[switch]$Stop,
[string]$MachineName,
[string]$ServiceName
)
    write-host "Set-ServiceStatus function has been invoked from" $env:computername | send-logupdate
    if($start) #Declare variables for Starting a Service
    {
        $CheckStatus = "Stopped"
        $DesiredAction = {$service.Start()}
        $DesiredStatus = "Running"
        $ActionName = "start"
    }

    if($stop) #Decleare variables for Stopping a Service
    {
        $CheckStatus = "Running"
        $DesiredAction = {$service.Stop()}
        $DesiredStatus = "Stopped"
        $ActionName = "stop"
    }


    write-host "Request made to $ActionName $servicename on $machinename" | send-logupdate 

try
    {
    $Service = get-service $ServiceName -ComputerName $MachineName
    }
catch
    {
    send-logupdate -outputtext $Error{$error.count-1}.exception -errorlevel 8
    }

    if($Service.status -eq $CheckStatus)
    {
        send-logupdate -outputtext "Status verified as" $Service.status 
        $DesiredAction.invoke()
        $service.waitforstatus($DesiredStatus,'00:01:00')
    }
    else
    {
        send-logupdate -outputtext "Service was" $Service.status " this is not desired state!" -ErrorLevel "Error"
    }

    $Service = get-service $ServiceName -ComputerName $MachineName
    wirte-host $Service.status

    if($Service.status -eq $DesiredStatus)
    {
       wirte-host "The Service is running now"
    }

}