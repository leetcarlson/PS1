<#
.SYNOPSIS
Test-PortConnection 'pings' a specific port on the target computer.
.DESCRIPTION
Test-PortConnection attempts to establish a connection to a specific port on an indetified computer.
.PARAMETER PortNumber
PortNumber is the integer number of the port to be tested.
.PARAMETER ComputerName
ComputerName either the address or a name that can be resolved to an address for the target computer.
The default value is for the local computer.
.PARAMETER PingFirst
PingFirst. if this switch is specified there will be an initial attempt to ping the computer
using Test-Connection to check if the computer is online before attempting to connect to the
port.
.OUTPUTS
Test-ComputerPort returns True or False to indicate whether it not the utlility was able to
connect to the port on the identified computer.
.EXAMPLE
Test-PortConnection 1434 SQLServer01
.EXAMPLE
Test-PortConnection 135
.EXAMPLE
Test-PortConnection -PortNumber 1434 -ComputerName SQLServer01
.EXAMPLE
Test-PortConnection -PortNumber 1434 -ComputerName SQLServer01 -PingFirst
.NOTES
Test-PortConnection is designed to see of a port on a target computer is open. It starts by testing the
ComputerName address with Test-Connection before attempting to establisg a connection to the port.

This cmdlet utilises a .NET Framework TcpClient classs to see if it is possible to create a connection
to a specific port on the target server.
#>
function Test-PortConnection
{
Param
(
[int]$PortNumber,
[string]$ComputerName = “localhost”,
[switch]$PingFirst
)
$found = $true
if ($PingFirst)
{
$found = Test-Connection $ComputerName -Count 1 -Quiet
}
if ($found)
{
try
{
[System.Net.Sockets.TcpClient]$client = New-Object System.Net.Sockets.TcpClient($ComputerName,$PortNumber)
$found = $true
}
catch
{
$found = $false
}
}
return $found
}

Test-PortConnection -PortNumber 80 -ComputerName www.iu.edu