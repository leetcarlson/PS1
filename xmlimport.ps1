[xml]$Restartdetails = get-content B:\restart.xml

$MachineNames = $Restartdetails.machines.machine.name
$Services = $Restartdetails.machines.machine.service.name

foreach($MachineName in $MachineName)
{
    write-host $MachineName
}
