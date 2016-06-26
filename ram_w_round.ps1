$Memory = Get-WmiObject -Class Win32_ComputerSystem | select totalphysicalmemory
$RAM =  [math]::round(($memory.totalphysicalmemory/1GB),0)
write-host "$RAM GB"